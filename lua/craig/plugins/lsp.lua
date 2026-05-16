vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/lazydev.nvim", ft = "lua" },
      "williamboman/mason.nvim",
      "saghen/blink.cmp",
      { "j-hui/fidget.nvim", opts = {} },
      "stevearc/conform.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        air = true,
        r_language_server = true,
        bashls = true,
        gopls = true,
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
            },
          },
        },
        rust_analyzer = {
          diagnostic = {
            refreshSupport = false,
          },
        },
        svelte = true,
        templ = true,
        cssls = true,
        terraformls = true,

        -- pyright = true,
        ruff = true,
        ty = true,

        ts_ls = true,
        tailwindcss = true,

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        intelephense = true,
        elixirls = true,
      }

      require("mason").setup()

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end

        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(name, config)
      end

      vim.lsp.enable(vim.tbl_keys(servers))

      local disable_semantic_tokens = {
        lua = true,
      }

      local conform = require("conform")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
          local opts = { buffer = bufnr }

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          local has_telescope = pcall(require, "telescope")
          if has_telescope then
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
          else
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          end

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        float = {
          style = "minimal",
          border = "rounded",
        },
      })

      vim.keymap.set("n", "<leader>dl", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
        else
          vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
        end
      end)

      conform.setup({
        default_format_opts = {
          lsp_format = "fallback",
          quiet = false,
        },
        formatters_by_ft = {
          go = { "gofmt" },
          lua = { "stylua" },
          python = { "ruff_format", "ruff_organize_imports" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          r = { "air" },
          svelte = { "prettier" },
          sql = { "sqlfluff" },
          rust = { "rustfmt" },
          json = { "jq" },
          yaml = { "prettier" },
        },
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
      })
    end,
  },
}
