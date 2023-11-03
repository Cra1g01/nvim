return {
    "rose-pine/neovim",
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            disable_background = true,
        })
        vim.cmd.colorscheme("rose-pine")
    end,
}

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
