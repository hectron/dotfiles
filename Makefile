stow_dirs := $(wildcard */)

.PHONY: *

default:

dry-run:
	stow --simulate --restow --target $(HOME) --verbose $(stow_dirs)

install:
	stow --restow --target $(HOME) $(stow_dirs)

uninstall:
	stow --target $(HOME) -D $(stow_dirs)

dry-uninstall:
	stow --no --verbose --target $(HOME) -D $(stow_dirs)
