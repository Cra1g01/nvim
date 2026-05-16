local ts = require("nvim-treesitter")

vim.treesitter.language.register("vimdoc", { "help" })

local available = {}
for _, l in ipairs(ts.get_available()) do
  available[l] = true
end

local installing = {}
local pending = {}

local function start_treesitter(buf, ft, lang)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return false
  end

  local ok, added = pcall(vim.treesitter.language.add, lang)
  if not ok or not added then
    return false
  end

  if not pcall(vim.treesitter.start, buf, lang) then
    return false
  end

  if ft == "php" then
    vim.bo[buf].syntax = "php"
  end

  return true
end

local function install_parser(buf, lang)
  pending[lang] = pending[lang] or {}
  pending[lang][buf] = true

  if installing[lang] then
    return
  end

  installing[lang] = true

  local ok, task = pcall(ts.install, { lang })
  if not ok or not task or not task.await then
    installing[lang] = nil
    pending[lang] = nil
    vim.notify("Could not install treesitter parser for " .. lang .. ": " .. tostring(task), vim.log.levels.WARN)
    return
  end

  task:await(function(err, success)
    local buffers = pending[lang]
    installing[lang] = nil
    pending[lang] = nil

    vim.schedule(function()
      if err or not success then
        local message = "Treesitter parser install failed for " .. lang
        if err then
          message = message .. ": " .. tostring(err)
        end
        vim.notify(message, vim.log.levels.WARN)
        return
      end

      for pending_buf in pairs(buffers or {}) do
        if vim.api.nvim_buf_is_loaded(pending_buf) then
          local pending_ft = vim.bo[pending_buf].filetype
          if vim.treesitter.language.get_lang(pending_ft) == lang then
            start_treesitter(pending_buf, pending_ft, lang)
          end
        end
      end
    end)
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TSMainAuto", { clear = true }),
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang or not available[lang] then
      return
    end

    if start_treesitter(buf, ft, lang) then
      return
    end

    install_parser(buf, lang)
  end,
})

vim.keymap.set("n", "tsc", "<cmd>TSContext toggle<CR>")
