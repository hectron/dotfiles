# Dotfiles

<img width="1098" height="953" alt="image" src="https://github.com/user-attachments/assets/cc2d8ad3-7094-4cc6-8cb2-a349e9dc2e5e" />

This is a collection of dotfiles that I tend to use. They are all managed via [`mise`][mise].

To get started, install [`mise`][mise] and then:

```zsh
make bootstrap
```

This links `mise`'s config into place, then lets `mise bootstrap` take it from there — cloning repos, installing packages, and symlinking the rest of the dotfiles.

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
| `./wezterm/.config/wezterm/` | `$HOME/.config/wezterm/` |

## Colors

This setup primarily uses [**Rose Pine**](https://rosepinetheme.com/) as the theme.

[mise]: https://mise.jdx.dev/
