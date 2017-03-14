# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -x OMF_PATH "$XDG_DATA_HOME/omf"
  or set -x OMF_PATH "$HOME/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# My settings
set -x PATH /usr/local/sbin $PATH

# Elasticsearch
# set -x PATH /usr/local/Cellar/elasticsearch/2.1.1/libexec/bin $PATH
set -x PATH /usr/local/Cellar/elasticsearch@1.7/1.7.6/bin $PATH

# Python
set -x PYTHONPATH /usr/local/lib/python2.7/site-packages/

# Git
set -x PATH /usr/local/share/git-core/contrib/diff-highlight $PATH

# rbenv
set -x RBENV_ROOT ~/.rbenv
status --is-interactive; and . (rbenv init -|psub)

# nvm
set -x NVM_DIR ~/.nvm

# direnv
eval (direnv hook fish)

# exenv
set -x EXENV_ROOT ~/.exenv
set PATH ~/.exenv/shims $PATH
eval (exenv rehash)

# homebrew cask option
set -x HOMEBREW_CASK_OPTS --appdir=/Applications

# Homebrew
set -x HOMEBREW_GITHUB_API_TOKEN 8024d88a7af824245cf431bab016273230880e48

# bobthefish options

# set -g theme_display_git yes
# set -g theme_display_git_untracked yes
# set -g theme_display_git_ahead_verbose yes
# set -g theme_git_worktree_support yes
# set -g theme_display_vagrant yes
# set -g theme_display_docker_machine yes
# set -g theme_display_hg yes
# set -g theme_display_virtualenv yes
set -g theme_display_ruby yes
# set -g theme_display_user yes
# set -g theme_display_vi yes
# set -g theme_display_date yes
# set -g theme_display_cmd_duration yes
# set -g theme_title_display_process yes
# set -g theme_title_display_path yes
# set -g theme_title_use_abbreviated_path yes
set -g theme_date_format "+%a %H:%M"
# set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
# set -g theme_nerd_fonts yes
# set -g theme_show_exit_status yes
# set -g default_user your_normal_user
set -g theme_color_scheme solarized-dark
# set -g fish_prompt_pwd_dir_length 0
# set -g theme_project_dir_length 1
