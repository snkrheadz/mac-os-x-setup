# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -x OMF_PATH "$XDG_DATA_HOME/omf"
  or set -x OMF_PATH "$HOME/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# My settings
set -x PATH /usr/local/sbin $PATH

# Homebrew
# set -x HOMEBREW_GITHUB_API_TOKEN

# Elasticsearch
# set -x PATH /usr/local/Cellar/elasticsearch/2.1.1/libexec/bin $PATH
set -x PATH /usr/local/Cellar/elasticsearch17/1.7.4/bin $PATH

# Python
set -x PYTHONPATH /usr/local/lib/python2.7/site-packages/

# Git
set -x PATH /usr/local/share/git-core/contrib/diff-highlight $PATH

# rbenv
set -x RBENV_ROOT /usr/local/var/rbenv
status --is-interactive; and . (rbenv init -|psub)

# nvm
set -x NVM_DIR ~/.nvm

# direnv
eval (direnv hook fish)

# exenv
set -x EXENV_ROOT /usr/local/var/exenv
set PATH /usr/local/var/exenv/shims $PATH
eval (exenv rehash)

# homebrew cask option
set -x HOMEBREW_CASK_OPTS --appdir=/Applications

set -g theme_display_vagrant yes
set -g theme_display_ruby yes
set -g theme_date_format "+%a %H:%M"