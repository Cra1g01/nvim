local base = require("formatter.base")

local M = {}

M.format = function()
    base.format("Prettier", string.format("prettier --stdin-filepath '%s'", vim.fn.expand("%")))
end
M.setup = function()
    print("FORMATTER: Prettier")
    base.setup("formatter.prettier")
end

return M
