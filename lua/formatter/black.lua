local base = require("formatter.base")

local M = {}

M.format = function()
    base.format("Black", "black -q - ")
end
M.setup = function()
    base.setup("formatter.black")
end

return M
