# Dotfiles

Install all the dotfiles using [`stow`](https://www.gnu.org/software/stow/manual/stow.html).

## Installing

```shell
git clone git@github.com:hectron/dotfiles.git && cd $_

# Test installing the dotfiles
make dry-run

# Install dotfiles
make install
```

## Directory Structure

The top-level directories are organized to group things conceptually. In practice, the directory structure inside the
top-level directory will be what is set up by `stow`.

In other words, for something like the `vim/` directory -- the `.vim` directory will be setup in the user's `$HOME`
directory. The files that live inside the `vim/` directory will be placed in the user's `$HOME`.

After installing, this is what the directory structure will look like:

```shell
$HOME/.vim/<whatever>
$HOME/.vimrc
$HOME/.vimrc.plugins
```

## Tooling

This repository primarily uses neovim (0.5+)

- [sharkdp/bat](https://github.com/sharkdp/bat)
- [sharkdp/fd](https://github.com/sharkdp/fd)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [tldr-pages/tldr](https://github.com/tldr-pages/tldr)

## Colors

This setup primarily uses SpaceDuck as the theme.

- [SpaceDuck Terminal Config](https://github.com/pineapplegiant/spaceduck-terminal)
- [SpaceDuck Vim Config](https://github.com/pineapplegiant/spaceduck)
- [SpaceDuck Tmux Config](https://github.com/pineapplegiant/spaceduck-terminal/tree/main/tmux)
