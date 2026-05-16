vim.g.mapleader = " "

local function gh(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("PackBuildHooks", { clear = true }),
  callback = function(event)
    local kind = event.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    local name = event.data.spec.name
    if name == "telescope-fzf-native.nvim" then
      local result = vim.system({ "make" }, { cwd = event.data.path, text = true }):wait()
      if result.code ~= 0 then
        vim.notify(result.stderr, vim.log.levels.ERROR, { title = "telescope-fzf-native.nvim build failed" })
      end
    elseif name == "nvim-treesitter" then
      local ok, err = pcall(function()
        if not event.data.active then
          vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd.TSUpdate()
      end)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR, { title = "nvim-treesitter update failed" })
      end
    end
  end,
})

vim.pack.add({
  { src = gh("b0o/SchemaStore.nvim") },
  { src = gh("rafamadriz/friendly-snippets") },
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1") },
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  { src = gh("stevearc/conform.nvim") },
  { src = gh("j-hui/fidget.nvim") },
  { src = gh("folke/lazydev.nvim") },
  { src = gh("williamboman/mason.nvim") },
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("nvim-treesitter/nvim-treesitter-context") },
  { src = gh("stevearc/oil.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope-fzf-native.nvim") },
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("folke/trouble.nvim") },
  { src = gh("mbbill/undotree") },
  { src = gh("tpope/vim-fugitive") },
}, {
  confirm = false,
  load = true,
})

for _, module in ipairs({
  "colorscheme",
  "completion",
  "lsp",
  "treesitter",
  "telescope",
  "oil",
  "trouble",
  "undotree",
  "fugitive",
}) do
  require("craig.plugins." .. module)
end
