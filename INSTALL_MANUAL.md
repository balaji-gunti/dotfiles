# Manual Installation Guide

This guide explains the installation process step by step.

## Prerequisites

```bash
sudo apt update
sudo apt install -y git curl wget ripgrep fd-find build-essential xclip fzf unzip stow python3 lua5.1 npm nodejs lazygit fontconfig
```

---

## Font

Install JetBrains Mono Nerd Font:

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -f -v
```

---

## Terminal (Kitty)

```bash
sudo apt install -y kitty
ln -sf ~/dotfiles/kitty/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

---

## Tmux

```bash
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

**Install plugins:** Start tmux and press `Ctrl-a` + `I`

---

## Yazi

```bash
tmp_dir=$(mktemp -d)
curl -Ls https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.tar.gz | tar xz -C "$tmp_dir"
mv "$tmp_dir/yazi-x86_64-unknown-linux-gnu/yazi" ~/.local/bin/
rm -rf "$tmp_dir"

mkdir -p ~/.config/yazi
ln -sf ~/dotfiles/yazi/.config/yazi/* ~/.config/yazi/
```

---

## Neovim

```bash
sudo apt install -y neovim
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim/.config/nvim/* ~/.config/nvim/
```

**First run:** Open nvim and wait for plugins to install. Then run `:Mason` to install LSP servers.

---

## Optional: Vim

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/undodir

# Install plugins
vim +PlugInstall
```
