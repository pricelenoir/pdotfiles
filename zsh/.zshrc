# ~/.zshrc
typeset -U path
alias ls='ls -F --color=auto'

# GNU tools first on macOS
if [[ "$OSTYPE" == darwin* ]]; then
    for gnu in coreutils gnu-sed grep findutils gawk gnu-tar; do
        PATH="/opt/homebrew/opt/$gnu/libexec/gnubin:$PATH"
    done
    unset gnu
fi

export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null && eval "$(mise activate zsh)"

command -v starship >/dev/null && eval "$(starship init zsh)"

command -v bat >/dev/null && alias cat='bat --paging=never --style=plain'

export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# Completion
zcomp="$HOME/.cache/zsh/completions"
mkdir -p "$zcomp"
fpath=("$zcomp" $fpath)
for spec in "gh:completion -s zsh" "mise:completion zsh" "uv:generate-shell-completion zsh"; do
    tool=${spec%%:*}
    bin=$(command -v "$tool") || continue
    [[ -s "$zcomp/_$tool" && "$zcomp/_$tool" -nt "$bin" ]] || "$bin" ${=spec#*:} > "$zcomp/_$tool" 2>/dev/null
done
unset zcomp spec tool bin
autoload -Uz compinit && compinit

command -v fzf >/dev/null && [[ -t 0 ]] && source <(fzf --zsh)

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
