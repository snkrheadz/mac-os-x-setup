# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -x OMF_PATH "$XDG_DATA_HOME/omf"
  or set -x OMF_PATH "$HOME/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# bin
set -x PATH $PATH $HOME/bin
set -x PATH $PATH /usr/local/sbin

# direnv
eval (direnv hook fish)

# git
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

# python
source (pyenv init - | psub)

# go
source (goenv init - | psub)

# homebrew cask option
set -x HOMEBREW_CASK_OPTS --appdir=/Applications

# gcloud
# The next line updates PATH for the Google Cloud SDK.
bass source '/Users/akira/bin/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
bass source '/Users/akira/bin/google-cloud-sdk/completion.bash.inc'


# bobthefish options
set -g theme_display_ruby yes
set -g theme_date_format "+%a %H:%M"
set -g theme_powerline_fonts yes
set -g theme_color_scheme solarized-dark
