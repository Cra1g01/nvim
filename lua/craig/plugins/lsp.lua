vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "WhoIsSethDanie/mason-tool-installer.nvim",
      "saghen/blink.cmp",

      { "j-hui/fidget.nvim", opts = {} },

      "stevearc/conform.nvim",

      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("neodev").setup()

      -- local capabilities = nil
      -- if pcall(require, "cmp_nvim_lsp") then
      --   capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- end

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        gopls = true,
        lua_ls = true,
        rust_analyzer = {
          diagnostic = {
            refreshSupport = false,
          },
        },
        svelte = true,
        templ = true,
        cssls = true,
        terraformls = true,

        pyright = true,

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

        r_language_server = true,
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "stylua",
        "lua_ls",
        "isort",
        "black",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      -- require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      local conform = require("conform")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
          local opts = { buffer = 0 }

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          local ts = require("telescope")
          if ts then
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
          else
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          end
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbold() end, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

          vim.keymap.set("n", "<space>f", function()
            vim.notify "Formatting"
            conform.format({
              lsp_fallback = true,
              quiet = true,
            })
          end, opts)

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
        },
        formatters = {
            black = {
              prepend_args = { "--line-length", "79" },
            },
        },
      }
    end,
  },
}
