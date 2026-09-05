# Dotfiles

This is a collection of dotfiles that I tend to use. They are all managed via [`mise`][mise].

To get started, install [`mise`][mise] and then:

```zsh
mkdir -p ~/.config/mise/
ln -s mise/.config/mise/config.toml ~/.config/mise/config.toml
mise bootstrap
```

## Installing tools

```zsh
mise install
```

## Directory Structure

The top-level directories are organized to group things conceptually. In practice, the directory structure inside the top-level directory was what was set up by `stow` when I first
set up my dotfiles. Each directory that is stowed contains the folder structure **that is relative to the user's home directory**. For example:


| Repo folder | Destination |
| --- | --- |
| `./nvim/.config/nvim/` | `$HOME/.config/nvim/` |
| `./shell/Brewfile` | `$HOME/Brewfile` |
| `./git/.gitconfig` | `$HOME/.gitconfig` |
| `./alacritty/.config/alacritty/` | `$HOME/.config/alacritty/` |

## Colors

This setup primarily uses [**Rose Pine**](https://rosepinetheme.com/) as the theme.

[mise]: https://mise.jdx.dev/
