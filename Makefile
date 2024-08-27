stow_dirs := $(wildcard */)

.PHONY: *

default:

dry-run:
	stow --simulate --target --restow $(HOME) --verbose $(stow_dirs)

install:
	stow --target --restow $(HOME) $(stow_dirs)

uninstall:
	stow --target $(HOME) -D $(stow_dirs)

dry-uninstall:
	stow --no --verbose --target $(HOME) -D $(stow_dirs)
