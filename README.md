# Neovim Config

This is my Lua Neovim config.

## Install

Prerequisites:
- Neovim 0.12 or later
- ripgrep
- `tar`
- `curl`
- `tree-sitter-cli`
- a C compiler

## Plugins

lazy.nvim is used to manage plugins. Plugins should install automatically on first launch.

This config uses the `main` branch of `nvim-treesitter`, so keep Neovim on 0.12+ and run `:TSUpdate` after plugin upgrades.

## LSPs and formatting

This config uses Neovim's built-in LSP (`vim.lsp.config()` / `vim.lsp.enable()`), `blink.cmp` for completion,
Mason for external tooling, and Conform for formatting.

Language servers and formatters are **not** installed automatically. Install what you need with `:Mason`
or provide the tools on your `$PATH`.

See `lua/craig/plugins/lsp.lua` for the configured servers and formatters.

---------------------
Credit to ThePrimeagen and teej_dv for the bulk of my original config!
