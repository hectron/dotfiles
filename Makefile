.PHONY: bootstrap

bootstrap:
	mkdir -p $(HOME)/.config/mise
	ln -sfn $(CURDIR)/mise/.config/mise/config.toml $(HOME)/.config/mise/config.toml
	mise bootstrap
