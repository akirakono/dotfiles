DOTFILES_EXCLUDES := .git
DOTFILES_TARGET   := $(wildcard .??*) $(wildcard bin/*)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

# XDG_CONFIG_DIRS := $(wildcard config/*)
# 
# XDG_CONFIG_HOME ?= ${HOME}/.config
# 
info:
	@echo ${DOTFILE_FILES}

.PHONY: deploy, deploy_dot_config, init

#	@$(foreach val, $(XDG_CONFIG_DIRS), ln -sfnv $(abspath $(val)) $(XDG_CONFIG_HOME)/$(subst config/,,$(val));)

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)



# deploy: deploy_dot_config
# 	@$(foreach val, $(DOTFILES_FILES), echo ln -sfnv $(abspath $(val)) $shell($(HOME)/$(val);)

# xdg_config:
# 	ln -svf $(DOTFILES_XDG_CONFIG) $(XDG_CONFIG_HOME)

# $(addprefix $(HOME)/, $(DOT_CONFIG_FILES)):
# 	echo mkdir -p $(dir $@)

# init:
# 	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

