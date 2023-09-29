require("rose-pine").setup({
	disable_background = true,
})

-- require("material.functions").change_style("deep ocean")

function SetBackground(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetBackground()

-- rose-pine
-- - main
-- - moon
-- - dawn

-- gruvbox
-- - dark
-- - light

-- nightfox
-- - nightfox
-- - dayfox
-- - dawnfox
-- - duskfox
-- - nordfox
-- - terrafox
-- - carbonfox

-- material
-- - darker
-- - lighter
-- - oceanic
-- - palenight
-- - deep ocean
-- - :lua require("material.functions").find_style()

-- github
-- - github_dark
-- - github_dark_dimmed
-- - github_dark_high_contrast
-- - github_dark_colorblind
-- - github_dark_tritanopia
-- - github_light
-- - github_light_high_contrast
-- - github_light_colorblind
-- - github_light_tritanopia
