return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lsp_zero = require("lsp-zero")

        mason.setup()

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "tsserver",
            },
            automatic_installation = true,
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
            }
        })
    end,
}
