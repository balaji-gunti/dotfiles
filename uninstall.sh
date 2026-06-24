#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

remove_configs() {
    log_info "Removing configurations..."

    rm -f "$HOME/.config/kitty/kitty.conf"
    rm -f "$HOME/.tmux.conf"
    rm -f "$HOME/.config/nvim"/*
    rm -f "$HOME/.config/yazi"/*
    sudo rm -f /usr/local/bin/cht
    rm -f "$HOME/.local/bin/yazi"

    rm -rf "$HOME/.vim/plugged"
    rm -f "$HOME/.vim/autoload/plug.vim"
    rm -f "$HOME/.vimrc"
    rm -rf "$HOME/.vim/undodir"

    log_info "Configurations removed"
}

remove_tmux_plugins() {
    log_info "Removing Tmux plugins..."
    rm -rf "$HOME/.tmux/plugins/tpm"
    log_info "Tmux plugins removed"
}

main() {
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}  Dotfiles Uninstall${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""

    if [[ "$EUID" -eq 0 ]]; then
        log_error "Please run as regular user, not root"
        exit 1
    fi

    log_warn "This will remove:"
    echo "  - All configuration symlinks"
    echo "  - Tmux plugins"
    echo "  - Vim plugins and vim-plug"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Cancelled"
        exit 0
    fi

    remove_configs
    remove_tmux_plugins

    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Uninstall Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    log_info "Note: System packages (kitty, tmux, neovim) were NOT removed"
    log_info "Remove them manually with your package manager if needed"
    echo ""
}

main "$@"
