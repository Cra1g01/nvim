local M = {}

M.format = function(formatter, cmd)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local input = table.concat(lines, "\n")

    print(string.format("FORMATTER: Formatting with %s", formatter))
    local formatted = vim.fn.system(cmd, input)

    if vim.v.shell_error ~= 0 then
        print(string.format("FORMATTER: Error while formatting with %s", formatter))
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(formatted, "\n"))
end

M.setup = function(formatter)
    vim.keymap.set("n", "<leader>f", string.format(":lua require('%s').format()<CR>", formatter), { noremap = true, silent = true, buffer = true })
end

return M
