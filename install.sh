#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

case "$(uname -s)" in
Darwin)
    if [ ! -x /opt/homebrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew bundle --file=Brewfile
    ;;
Linux)
    pkgs="git git-lfs tmux zsh stow curl wget jq unzip ca-certificates file less man-db wl-clipboard xclip fontconfig"
    if command -v apt-get >/dev/null; then
        sudo apt-get update
        sudo apt-get install -y $pkgs build-essential xz-utils procps openssh-client locales
    elif command -v dnf >/dev/null; then
        sudo dnf install -y $pkgs gcc make xz procps-ng which openssh-clients glibc-langpack-en
    elif command -v pacman >/dev/null; then
        sudo pacman -S --needed --noconfirm $pkgs base-devel xz procps-ng which openssh
    else
        echo "Unsupported package manager; install manually: $pkgs" >&2
        exit 1
    fi
    if [ -f /etc/locale.gen ] && ! locale -a | grep -qi '^en_US\.utf-\?8$'; then
        sudo sed -i 's/^# *\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
        sudo locale-gen
    fi
    zsh_path="$(command -v zsh)"
    if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$zsh_path" ]; then
        grep -qx "$zsh_path" /etc/shells || echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
        sudo usermod -s "$zsh_path" "$(id -un)"
    fi
    if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
        mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
        curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz \
            | tar -xJ -C "$HOME/.local/share/fonts/JetBrainsMono"
        fc-cache -f
    fi
    command -v mise >/dev/null || curl -fsSL https://mise.run | sh
    ;;
esac
export PATH="$HOME/.local/bin:$PATH"

mkdir -p "$HOME/.claude/hooks"
touch "$HOME/.gitconfig"
stow */

git config filter.claude-settings.clean "jq 'del(.modelSettings)'"
git lfs install >/dev/null

mise install
command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash
