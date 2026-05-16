return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      vim.treesitter.language.register("vimdoc", { "help" })

      local available = {}
      for _, l in ipairs(ts.get_available()) do
        available[l] = true
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

          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(buf, lang)
            if ft == "php" then
              vim.bo[buf].syntax = "php"
            end
            return
          end

          local ok, task = pcall(ts.install, { lang })
          if ok and task and task.wait then
            task:wait(30000)
            if vim.treesitter.language.add(lang) then
              vim.treesitter.start(buf, lang)
              if ft == "php" then
                vim.bo[buf].syntax = "php"
              end
            end
          end
        end,
      })

      vim.keymap.set("n", "tsc", "<cmd>TSContext toggle<CR>")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context" },
}
