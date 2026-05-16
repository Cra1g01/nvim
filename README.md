# Neovim Config

This is my Lua Neovim config.

## Install

Prerequisites:
- Neovim 0.12 or later
- `git`
- ripgrep
- `tar`
- `curl`
- `make`
- `tree-sitter-cli`
- a C compiler

## Plugins

Neovim's built-in `vim.pack` is used to manage plugins. Plugins should install automatically on first launch.
Plugin revisions are tracked in `nvim-pack-lock.json`.

This config uses the `main` branch of `nvim-treesitter`, so keep Neovim on 0.12+. A `vim.pack` hook runs `:TSUpdate` after plugin install/update.

## LSPs and formatting

This config uses Neovim's built-in LSP (`vim.lsp.config()` / `vim.lsp.enable()`), `blink.cmp` for completion,
Mason for external tooling, and Conform for formatting.

Language servers and formatters are **not** installed automatically. Install what you need with `:Mason`
or provide the tools on your `$PATH`.

See `lua/craig/plugins/lsp.lua` for the configured servers and formatters.

---------------------
Credit to ThePrimeagen and teej_dv for the bulk of my original config!
