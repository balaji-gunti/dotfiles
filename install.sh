#!/usr/bin/env bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
OS="$(uname -s)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
    if [[ "$OS" != "Linux" ]]; then
        log_error "Unsupported OS: $OS (only Linux is supported)"
        exit 1
    fi

    if ! command -v apt-get &> /dev/null; then
        log_error "Only Debian/Ubuntu-based systems are supported"
        exit 1
    fi

    log_info "Detected OS: $OS (debian)"
}

install_prerequisites() {
    log_info "Installing prerequisites..."

    sudo apt update
    sudo apt install -y git curl wget ripgrep fd-find build-essential xclip fzf unzip stow python3 lua5.1 npm nodejs lazygit fontconfig

    log_info "Prerequisites installed"
}

install_font() {
    log_info "Installing JetBrains Mono Nerd Font..."

    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"

    (cd "$font_dir" && \
        curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip && \
        unzip -o JetBrainsMono.zip && \
        rm -f JetBrainsMono.zip)

    fc-cache -f -v 2>/dev/null || true
    log_info "Font installed"
}

install_kitty() {
    log_info "Installing Kitty..."

    if command -v kitty &> /dev/null; then
        log_warn "Kitty already installed"
        return
    fi

    sudo apt install -y kitty

    log_info "Kitty installed"
}

install_tmux() {
    log_info "Installing Tmux..."

    if command -v tmux &> /dev/null; then
        log_warn "Tmux already installed"
    else
        sudo apt install -y tmux
    fi

    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    log_info "Tmux installed"
}

install_yazi() {
    log_info "Installing Yazi..."

    if command -v yazi &> /dev/null; then
        log_warn "Yazi already installed"
        return
    fi

    local tmp_dir
    tmp_dir=$(mktemp -d)
    curl -Ls https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.tar.gz | tar xz -C "$tmp_dir"
    mv "$tmp_dir/yazi-x86_64-unknown-linux-gnu/yazi" "$HOME/.local/bin/"
    rm -rf "$tmp_dir"

    log_info "Yazi installed"
}

install_neovim() {
    log_info "Installing Neovim..."

    if command -v nvim &> /dev/null; then
        local current_version
        current_version=$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)
        log_warn "Neovim already installed (version $current_version)"
    else
        sudo apt install -y neovim
    fi

    log_info "Neovim installed"
}

setup_configs() {
    log_info "Setting up configurations..."

    mkdir -p "$HOME/.config/"{nvim,kitty,yazi,tmux}
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.vim/undodir" 2>/dev/null || true

    ln -sf "$DOTFILES_DIR/kitty/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$DOTFILES_DIR/nvim/.config/nvim"/* "$HOME/.config/nvim/"
    ln -sf "$DOTFILES_DIR/yazi/.config/yazi"/* "$HOME/.config/yazi/"

    chmod +x "$DOTFILES_DIR/cht.sh"
    sudo ln -sf "$DOTFILES_DIR/cht.sh" /usr/local/bin/cht

    log_info "Configurations linked"
}

install_vim_plugins() {
    log_info "Installing vim-plug and Vim plugins (optional)..."

    if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

    log_info "Vim configured. Run 'vim +PlugInstall' to install plugins"
}

main() {
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Dotfiles Installation${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""

    detect_os

    if [[ "$EUID" -eq 0 ]]; then
        log_error "Please run as regular user, not root"
        exit 1
    fi

    if [[ ! -d "$DOTFILES_DIR" ]]; then
        log_error "Dotfiles directory not found at $DOTFILES_DIR"
        log_error "Clone your dotfiles first: git clone https://github.com/yourusername/dotfiles.git ~/dotfiles"
        exit 1
    fi

    local include_vim=false
    if [[ "$1" == "--with-vim" ]]; then
        include_vim=true
        log_info "Including Vim setup"
    fi

    install_prerequisites
    install_font
    install_kitty
    install_tmux
    install_yazi
    install_neovim
    setup_configs

    if $include_vim; then
        install_vim_plugins
    fi

    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Start tmux: tmux"
    echo "  2. Install Tmux plugins: Ctrl-a + I"
    echo "  3. Open nvim: nvim (plugins will install automatically)"
    echo "  4. Install LSP servers in nvim: :Mason"
    echo ""
    echo "Keybindings:"
    echo "  - Ctrl-a: Tmux prefix (instead of Ctrl-b)"
    echo "  - Space: Neovim leader key"
    echo "  - Ctrl-h/j/k/l: Navigate panes in both tmux and vim"
    echo ""
}

main "$@"
