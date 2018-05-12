MAKEFLAGS+=--no-builtin-rules
SHELL:=/usr/bin/env bash

# Functions
packages_from_file=\
	$(patsubst %/$1,%$(if $2,/$2,),\
	$(filter $(wildcard */$1),$(addsuffix /$1,$(packages))))

# Search for packages, ensuring that OS packages are first with any filters
# http://blog.jgc.org/2007/06/escaping-comma-and-space-in-gnu-make.html
,:=,
space:=
space+=
$(space):=
$(space)+=
os:=$(shell source helpers && echo $$OS)
gui:=$(shell source helpers && echo $$GUI)
os_packages:=debian macos ubuntu
packages:=common \
	$(filter $(os_packages),$(os))\
	$(filter-out common $(os_packages),$(subst /,,$(wildcard */)))
ifdef EXCLUDE
	packages:=$(filter-out $(subst $(,),$( ),$(EXCLUDE)),$(packages))
endif
ifdef INCLUDE
	packages:=$(filter $(subst $(,),$( ),$(INCLUDE)),$(packages))
endif
ifeq ($(os),macos)
	packages:=$(filter-out awesome,$(packages))
endif
ifeq ($(gui),)
	packages:=$(filter-out awesome,$(packages))
endif

# Search for specific files based on package
installers:=$(call packages_from_file,install.sh)
stows:=$(call packages_from_file,.stow-local-ignore)
envs:=\
	$(foreach p,$(packages),\
	$(sort\
	$(patsubst %/,%,$(dir\
	$(wildcard $p/*.zsh)))))

# Establish rules
installer_rules:=$(addsuffix /install.sh,$(installers))

.PHONY: help clean install symlink update $(installer_rules)
.SUFFIXES:

#
# Tasks
#
help: # https://blog.sneawo.com/blog/2017/06/13/makefile-help-target/
	@egrep '^(.+)\:\ .*##\ (.+)' ${MAKEFILE_LIST}\
	| sed 's/:.*##/#/'\
	| column -t -c 2 -s '#'
	@echo
	@echo "OS: $(os)"
	@echo
	@echo 'Packages:'
	@echo "  Install - $(sort $(installers))"
	@echo "  Symlink - $(sort $(stows))"
	@echo "    Shell - $(sort $(envs))"
	@echo
	@echo 'Variables:'
	@echo '  INCLUDE - Packages to only include (ex: node,tmux,zsh)'
	@echo '  EXCLUDE - Packages to exclude (ex: emacs,go,latex)'
clean: ## Clean up
	@printf '==> '
	stow -D $(stows)
install: $(installer_rules) ## Install required dependencies
symlink: ## Symlink configuration files
	@printf '==> '
	stow $(stows)
update: ## Update dotfiles
	@printf '==> '
	git pull --rebase --autostash --recurse-submodules
	@printf '==> '
	git submodule update --init --recursive

#
# Internal tasks
#
$(installer_rules): %/install.sh:
	@printf '==> '
	$@