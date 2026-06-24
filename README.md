# Dotfiles

My dev environment setup with Neovim, Tmux, Kitty, and Yazi.

## Quick Install

```bash
git clone https://github.com/balaji-gunti/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

To include Vim setup (optional):
```bash
./install.sh --with-vim
```

## What's Installed

- **Kitty** - Terminal emulator
- **Tmux** - Terminal multiplexer with TPM plugins
- **Neovim** - Main editor with LSP, Telescope, Treesitter, DAP
- **Yazi** - File manager
- **cht.sh** - Cheat sheet tool
- **JetBrains Mono Nerd Font** - Font with icons

## First Run

1. Start tmux: `tmux`
2. Install Tmux plugins: Press `Ctrl-a` then `I`
3. Open neovim: `nvim` (plugins install automatically)
4. Install LSP servers: Run `:Mason` inside nvim

## Uninstall

```bash
cd ~/dotfiles
./uninstall.sh
```
## Manual Setup

If you prefer manual installation, see [INSTALL_MANUAL.md](INSTALL_MANUAL.md).
