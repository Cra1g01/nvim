return {
    "tpope/vim-fugitive",
    lazy = true,
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

        local Fugitive_Group = vim.api.nvim_create_augroup("Fugitive_Group", {})

        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = Fugitive_Group,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git("push")
                end, opts)

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git("pull --rebase")
                end, opts)

                vim.keymap.set("n", "<leader>t", ":Git push -u origin", opts);
            end
        })
    end,
}
