# Neovim Config

This is my Lua Neovim config.

## Install
>Prerequisites:
> - neovim v0.9.1
> - ripgrep

With the prerequisites installed, clone this repository into `~/.config`.

Alternatively, clone my [.files](https://github.com/Cra1g01/.files) repo (recursively) and stow the files.

## Plugins
Packer is used to manage plugins.

To install the plugins:
- Open `nvim/lua/craig/packer.lua` and source with `:so`
- Run `:PackerSync`

See [packer.nvim](https://github.com/wbthomason/packer.nvim) for more info.

## LSPs
Mason manages LSPs, Linters, Formatters, etc.

lsp-zero is used for LSP integration.

rust_analyzer and tsserver are installed by default.

See [mason.nvim](https://github.com/williamboman/mason.nvim) for more info.

---------------------
Credit to ThePrimeagen for the bulk of this config!
