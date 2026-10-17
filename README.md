# My Dotfiles

Dotfiles for macOS and Linux, managed with GNU Stow. Dev tools are pinned with [mise](https://mise.jdx.dev).

## Installation

```bash
git clone https://github.com/pricelenoir/pdotfiles.git ~/pdotfiles
~/pdotfiles/install.sh
```

### Manual setup

1. Install GNU Stow (if not already installed)

2. (macOS) Install Homebrew packages:
   ```bash
   brew bundle --file=~/pdotfiles/Brewfile
   ```

3. Apply dotfiles, all at once or one package at a time:
   ```bash
   cd ~/pdotfiles
   mkdir -p ~/.claude/hooks   # keeps Claude Code's own data out of the repo
   stow */
   stow nvim tmux
   stow -D nvim               # unlink a package
   ```

4. Install dev tools:
   ```bash
   mise install
   ```

5. Install Claude Code:
   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   ```

## Packages

| Package    | Links into                            |
| ---------- | ------------------------------------- |
| `claude`   | `~/.claude`, `~/.config/ccstatusline` |
| `ghostty`  | `~/.config/ghostty`                   |
| `git`      | `~/.config/git/config`                |
| `lazygit`  | `~/.config/lazygit`                   |
| `mise`     | `~/.config/mise`                      |
| `nvim`     | `~/.config/nvim`                      |
| `starship` | `~/.config/starship.toml`             |
| `tmux`     | `~/.tmux.conf`                        |
| `zsh`      | `~/.zshrc`, `~/.zprofile`             |

## Tools

- `mise/.config/mise/config.toml`: cross-platform dev tools, with exact versions in `mise.lock`
- `Brewfile`: macOS packages and apps
- `install.sh`: Linux packages

## Updating

```bash
mise upgrade
mise lock -g --platform macos-arm64,linux-x64,linux-arm64   # then commit mise.lock
brew bundle --file=~/pdotfiles/Brewfile
brew bundle cleanup --file=~/pdotfiles/Brewfile             # lists packages not in the Brewfile
```
