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

The top-level directories are organized to group things conceptually. In practice, the directory structure inside the
top-level directory will be what is set up by `stow`.

In other words, for something like the `nvim/` directory -- the `.config` directory will be setup in the user's `$HOME`
directory. The files that live inside the `nvim/` directory will be placed in the user's `$HOME/.config`.

After installing, this is what the directory structure will look like:

```sh
$HOME/.config/nvim/init.lua
$HOME/.config/nvim/lua/user
$HOME/.config/nvim/lua/lsp/<whatever>
```

## Tooling

This repository primarily uses neovim (0.5+)

- [sharkdp/bat](https://github.com/sharkdp/bat)
- [sharkdp/fd](https://github.com/sharkdp/fd)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [tldr-pages/tldr](https://github.com/tldr-pages/tldr)

## Fonts

My font of choice is **PragmataPro**, but that is an expensive font and I haven't found a NERD font version of it.

I switch between **Iosevka Nerd Font** or **JetBraints Mono Nerd Font**.

## Colors

This setup primarily uses [**Catppuccin**](https://github.com/catppuccin/nvim) as the theme.
