stow_dirs := $(wildcard */)
stow_dirs := $(stow_dirs) .config

.PHONY: *

default:

dry-run:
	stow --no --target $(HOME) --verbose $(stow_dirs)

install:
	stow --target $(HOME) $(stow_dirs)

uninstall:
	stow --target $(HOME) -D $(stow_dirs)
