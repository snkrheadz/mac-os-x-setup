# bin
set -U fish_user_paths $HOME/bin /usr/local/sbin $fish_user_paths

# git
set -U fish_user_paths /usr/local/share/git-core/contrib/diff-highlight $fish_user_paths

# rails credentials:edit
set -x EDITOR vim

# nodebrew
set -U fish_user_paths $HOME/.nodebrew/current/bin $fish_user_paths

# direnv
eval (direnv hook fish)

# python
if which pyenv > /dev/null
  set -x PYENV_ROOT $HOME/.pyenv
  source (pyenv init - | psub)
end

# go
if which goenv > /dev/null
  source (goenv init - | psub)
end

# homebrew cask option
set -x HOMEBREW_CASK_OPTS --appdir=/Applications

# gcloud
# The next line updates PATH for the Google Cloud SDK.
#bass source '~/bin/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
#bass source '~/bin/google-cloud-sdk/completion.bash.inc'

#
# alias
#
alias ls="ls -lhFG $argv"
alias df="df -H $argv"
alias fd="find $argv[1] -type d"
alias displaydata="system_profiler SPDisplaysDataType"
alias grep="grep --color=always -I $argv"
alias gitbm="git branch --merged"
alias gitlog="git log --no-merges --date=short --pretty='format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s'"
alias rbenvup="brew upgrade rbenv ruby-build"
alias mergeapp="open /Applications/Xcode.app/Contents/Applications/FileMerge.app"
alias pip3freeze="pip3 freeze > requirements.txt"
alias curlh="curl -D - -s -o /dev/null $argv[1]"
alias docker-rm-all="docker rm (docker ps -a -q)"
alias docker-stop-all="docker stop (docker ps -a -q)"

#
# functions
#
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

#
# Key binding
#
function fish_user_key_bindings
  bind \cr peco_select_history
end

# ctrl+g
set GHQ_SELECTOR peco
