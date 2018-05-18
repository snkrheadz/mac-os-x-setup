# bin
set -x PATH $PATH $HOME/bin /usr/local/sbin

# git
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight

# direnv
eval (direnv hook fish)

# python
source (pyenv init - | psub)

# go
source (goenv init - | psub)

# homebrew cask option
set -x HOMEBREW_CASK_OPTS --appdir=/Applications

# gcloud
# The next line updates PATH for the Google Cloud SDK.
bass source '~/bin/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
bass source '~/bin/google-cloud-sdk/completion.bash.inc'

#
# functions
#
function ls --description 'List contents of directory'
  command ls -lhFG $argv
end

function df --description 'Displays disk free space'
  command df -H $argv
end

function fd --description 'List all the (sub)directory names in a direction'
  find $argv[1] -type d
end

function spDisplayData --description 'Show the profile for external display'
  system_profiler SPDisplaysDataType
end

function grep --description 'Colorful grep that ignores binary file and outputs line number'
  command grep --color=always -I $argv
end

function gf --description 'Run git fetch'
  command git fetch
end

function gdeletemergedcurrent --description 'Delete all local branches that is already merged to current branch (exludes master)'
  command git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
end

function gitlog --description 'Show git log in a nice format'
  git log --no-merges --date=short --pretty='format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s'
end

function pathlist --description 'Show a list of the paths on $PATH'
  for val in $PATH
    echo "$val"
  end
end

function imginfo --description 'print image on iterm2 with its pixelHeight and pixelWidth'
  imgcat $argv[1]; sips --getProperty pixelHeight --getProperty pixelWidth $argv[1]
end

function gitakinrt --description 'update local config for akinrt'
  git config --local user.email aki.d.sc@gmail.com
  git config --local user.name akinrt
end

function rupgrade --description 'shortcut command for upgrade rbenv and ruby-build depends on homebrew'
  brew upgrade rbenv ruby-build
end

function mergeapp --description 'open FileMerge.app in Xcode.app'
  open /Applications/Xcode.app/Contents/Applications/FileMerge.app
end

function pip3freeze --description 'create requirements.txt'
  pip3 freeze > requirements.txt
end

function curlh --description 'print headers'
  curl -D - -s -o /dev/null $argv[1]
end

#
# Key binding
#
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \c] peco_select_ghq_repository
end
