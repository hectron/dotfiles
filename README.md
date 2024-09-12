# Dotfiles

This is a collection of dotfiles that I tend to use. It also contains a `Brewfile`, which contains instructions on what software and fonts to install via Homebrew.

## Dependencies

| Tool | Reason |
| --- | --- |
| [Stow](https://www.gnu.org/software/stow/manual/stow.html) | Symlinking dotfiles |
| [Make](https://www.gnu.org/software/make/) | Provides commands to help with installation |

## Installing

```sh
git clone git@github.com:hectron/dotfiles.git && cd $_

# Test installing the dotfiles
make dry-run

# Install dotfiles
make install
```

### Installing/upgrading software

> [!INFO]
> This repository also provides a `Brewfile`, which can be used by Homebrew to automatically provision software.

```sh
cd ~
brew bundle
```

## Directory Structure

The top-level directories are organized to group things conceptually. In
practice, the directory structure inside the top-level directory will be what
is set up by `stow`. Each directory that is stowed contains the folder
structure **that is relative to the user's home directory**. For example:

| Repo folder | Destination |
| --- | --- |
| `./nvim/.config/nvim/` | `$HOME/.config/nvim/` |
| `./shell/Brewfile` | `$HOME/Brewfile` |
| `./git/.gitconfig` | `$HOME/.gitconfig` |
| `./alacritty/.config/alacritty/` | `$HOME/.config/alacritty/` |

## Colors

This setup primarily uses [**Catppuccin**](https://github.com/catppuccin/nvim) as the theme.
