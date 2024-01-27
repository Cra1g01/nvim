local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("Filetype", {
    pattern = {
        "html", "xml",
        "css", "scss",
        "javascript", "typescript",
        "javascriptreact", "typescriptreact",
        "svelte",
        "yaml",
    },
    command = "setlocal shiftwidth=2 tabstop=2"
})


local formatters_group = augroup("Formatters", {})

local formatters = {
    ["javascript"] = "formatter.prettier",
    ["javascriptreact"] = "formatter.prettier",
    ["svelte"] = "formatter.prettier",
    ["typescript"] = "formatter.prettier",
    ["typescriptreact"] = "formatter.prettier",
    ["python"] = "formatter.black",
}

autocmd("FileType", {
    group = formatters_group,
    pattern = "*",
    callback = function()
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        local formatter = formatters[filetype]
        if formatter == nil then
            return
        end
        require(formatter).setup()
    end
})
