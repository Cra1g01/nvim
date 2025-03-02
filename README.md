# Neovim Config

This is my Lua Neovim config.

## Install
Prerequisites:
 - neovim v0.9.1
 - ripgrep

With the prerequisites installed, clone this repository into `~/.config`.

Alternatively, clone my [.files](https://github.com/Cra1g01/.files) repo (recursively) and stow the files.

## Plugins
Lazy.nvim is used to manage plugins.

Plugins should install automatically.

See [lazy.nvim](https://github.com/folke/lazy.nvim) for more info.

## LSPs
Mason manages LSPs, Linters, Formatters, etc.

lsp-zero is used for LSP integration.

A number of lsps are installed are installed by default. See `lua/craig/plugins/lsp.lua`.

See [mason.nvim](https://github.com/williamboman/mason.nvim) for more info.

---------------------
Credit to ThePrimeagen and teej_dv for the bulk of my original config!
