local telescope = require("telescope")

telescope.setup({
  extensions = {
    fzf = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

telescope.load_extension("fzf")
pcall(telescope.load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<leader>pg", builtin.live_grep)
vim.keymap.set(
  "n",
  "<leader>pG",
  require("craig.telescope.multi-ripgrep"),
  { desc = "Live grep with file filters" }
)
vim.keymap.set("n", "<leader>pb", builtin.buffers)
vim.keymap.set("n", "<leader>p/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>pt", builtin.treesitter)
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>vh", builtin.help_tags)
vim.keymap.set("n", "<leader>en", function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
  })
end)
