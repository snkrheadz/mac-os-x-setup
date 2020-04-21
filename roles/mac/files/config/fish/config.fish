# bin
set -U fish_user_paths $HOME/bin /usr/local/sbin $fish_user_paths

# git
if test -d /usr/local/share/git-core/contrib/diff-highlight
  set -U fish_user_paths /usr/local/share/git-core/contrib/diff-highlight $fish_user_paths
end

# rails credentials:edit
set -x EDITOR vim

# direnv
if which direnv > /dev/null
  eval (direnv hook fish)
end

# nodebrew
if which nodebrew > /dev/null
  set -U fish_user_paths $HOME/.nodebrew/current/bin $fish_user_paths
end

# pyenv
if which pyenv > /dev/null
  set -x PYENV_ROOT $HOME/.pyenv
  source (pyenv init - | psub)
end

# goenv
if which goenv > /dev/null
  set -x GOPATH $HOME/.go
  set -U fish_user_paths $GOPATH/bin $fish_user_paths
  source (goenv init - | psub)
end

# helm@2
if test -d /usr/local/opt/helm@2/bin
  set -g fish_user_paths "/usr/local/opt/helm@2/bin" $fish_user_paths
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
alias ipfy="curl 'https://api.ipify.org?format=text'"

#
# functions
#
function mkdcd --description 'make directory and change directory to it'
  mkdir $argv[1]
  cd $argv[1]
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

function ghq-sync-all --description 'sync with a remote repository on entire repositories managed by ghq'
  ghq list | sed -E 's/^[^\/]+\/(.+)/\1/' | xargs -n 1 -P 10 ghq get -u
end

function git-change-lines
  if git rev-parse 2> /dev/null
    set authors (git shortlog -sne --all --no-merges | awk '{print $NF}')
    for author in $authors
      echo "----------------------------------------"
      echo $author
      git log --numstat --pretty="%H" --author="$author" --no-merges | awk 'NF==3{plus+=$1; minus+=$2} END {printf("total: %d (\x1b[32m+%d\033[m, \x1b[31m-%d\033[m)\n",plus+minus , plus, minus)}'
    end
  else
    echo 'fatal: not a git repository (or any of the parent directories): .git'
  end
end

#
# Key binding
#
function fish_user_key_bindings
  bind \cr peco_select_history
end

# ctrl+g
set GHQ_SELECTOR peco
