return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                ensure_installed = {
                    "c",
                    "go",
                    "javascript",
                    "lua",
                    "python",
                    "rust",
                    "typescript",
                    "vimdoc",
                },
            })
        end,
    },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-context" },
}
