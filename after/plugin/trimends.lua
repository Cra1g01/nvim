vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()

    vim.cmd([[keepjumps keeppatterns %s/\s\+$//e]])

    vim.fn.winrestview(view)
  end,
})
