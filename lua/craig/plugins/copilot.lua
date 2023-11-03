return {
    "github/copilot.vim",
    lazy = true,
    keys = { { "<leader>cp", ":lua print('Starting Copilot')<CR>", desc = "Start Copilot" } },
    config = function()
        vim.g.copilot_filetypes = {
            ["*"] = false,
            ["python"] = true,
            ["javascript"] = true,
            ["typescript"] = true,
            ["go"] = true,
            ["rust"] = true,
            ["css"] = true,
            ["html"] = true,
            ["c"] = true,
            ["cpp"] = true,
            ["r"] = true,
            ["json"] = true,
        }
    end,
}
