#!/usr/bin/env bash
set -euo pipefail

fail() { echo "FAIL: $*" >&2; exit 1; }

out=$(zsh -ic exit 2>&1) || fail "zsh exited with an error"
[ -z "$out" ] || fail "zsh startup printed: $out"

for tool in mise nvim rg fd fzf bat delta lazygit gh starship zoxide node python3 uv rtk; do
    zsh -ic "command -v $tool" >/dev/null || fail "missing: $tool"
done

zsh -ic 'mise install --dry-run' 2>&1 | grep -q 'all tools are installed' || fail "mise tools don't match mise.lock"

zsh -ic 'nvim --headless "+Lazy! restore" +qa' || fail "nvim config"

tmux -L dotfiles-test new-session -d
tmux -L dotfiles-test kill-server
for plugin in tpm tmux vim-tmux-navigator; do
    [ -d "$HOME/.tmux/plugins/$plugin" ] || fail "tmux plugin not installed: $plugin"
done

[ -z "$(zsh -ic "$HOME/.claude/hooks/rtk-check.sh")" ] || fail "rtk self-check"
git config --get core.pager | grep -q delta || fail "git pager is not delta"

if [ "$(uname -s)" = Darwin ]; then
    /Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config || fail "ghostty config"
fi

echo "All checks passed"
