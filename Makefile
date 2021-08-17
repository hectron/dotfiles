stow_dirs := $(wildcard */)

.PHONY: *

default:

dry-run:
	stow --no --target $(HOME) --verbose $(stow_dirs)

install:
	stow --target $(HOME) $(stow_dirs)

uninstall:
	stow --target $(HOME) -D $(stow_dirs)

dry-uninstall:
	stow --no --verbose --target $(HOME) -D $(stow_dirs)
