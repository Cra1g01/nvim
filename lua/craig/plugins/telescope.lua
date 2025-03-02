return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			extentions = {
				fzf = {},
			},
		})
		require("telescope").load_extension("fzf")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<C-p>", builtin.git_files)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags)
		vim.keymap.set("n", "<leader>en", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)
	end,
}
