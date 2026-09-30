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

The top-level folders are grouped by tool, a layout left over from when `stow` did the linking. `mise bootstrap` handles that now (see the `[dotfiles]` table in `mise/.config/mise/config.toml`), but the folders still mirror paths **relative to your home directory**, e.g.:


| Repo folder | Destination |
| --- | --- |
| `./nvim/.config/nvim/` | `$HOME/.config/nvim/` |
| `./shell/.aliases` | `$HOME/.aliases` |
| `./git/.gitconfig` | `$HOME/.gitconfig` |
| `./wezterm/.config/wezterm/` | `$HOME/.config/wezterm/` |

## Colors

This setup primarily uses [**Rose Pine**](https://rosepinetheme.com/) as the theme.

[mise]: https://mise.jdx.dev/
