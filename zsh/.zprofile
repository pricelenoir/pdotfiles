[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null && eval "$(mise activate zsh --shims)"
