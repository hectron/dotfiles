dry-install:
	echo "ln -s mise/.config/mise/config.toml $(HOME)/.config/mise/config.toml"

install:
	ln -s mise/.config/mise/config.toml $(HOME)/.config/mise/config.toml

uninstall:
	rm $(HOME)/.config/mise/config.toml

dry-uninstall:
	echo "rm $(HOME)/.config/mise/config.toml"
