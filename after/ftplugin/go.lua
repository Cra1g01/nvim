vim.opt_local.expandtab = false

local group = vim.api.nvim_create_augroup("GoFormatOnSave", { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = 0,
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      lsp_format = "fallback",
      timeout_ms = 500,
    })
  end,
})
