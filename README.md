# Dotfiles

Install all the dotfiles using [`stow`](https://www.gnu.org/software/stow/manual/stow.html).

## Installing

```sh
git clone git@github.com:hectron/dotfiles.git && cd $_

# Test installing the dotfiles
make dry-run

# Install dotfiles
make install
```

## Directory Structure

The top-level directories are organized to group things conceptually. In
practice, the directory structure inside the top-level directory will be what
is set up by `stow`. Each directory that is stowed contains the folder
structure **that is relative to the user's home directory**. For example:

| Repo folder | Destination |
| --- | --- |
| ./nvim/.config/nvim/ | $HOME/.config/nvim/ |
| ./shell/Brewfile | $HOME/Brewfile |
| ./git/.gitconfig | $HOME/.gitconfig |
| ./alacritty/.config/alacritty/ | $HOME/.config/alacritty/ |

## Tooling

This repository primarily uses neovim (>= 0.10)

- [sharkdp/bat](https://github.com/sharkdp/bat)
- [sharkdp/fd](https://github.com/sharkdp/fd)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [tldr-pages/tldr](https://github.com/tldr-pages/tldr)

## Fonts

My font of choice is **Iosevka Nerd Font Propo**.

## Colors

This setup primarily uses [**Catppuccin**](https://github.com/catppuccin/nvim) as the theme.
