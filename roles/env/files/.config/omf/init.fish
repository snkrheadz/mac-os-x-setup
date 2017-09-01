# plugins
set fish_plugins theme git rbenv rails brew bundler gem osx pbcopy better-alias gi peco z tmux

# functions
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

function gf --description 'Do a git fetch'
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

# keybind
function fish_user_key_bindings
  bind \cr peco_select_history
end

# gitsquash
function gitsquash --description 'Squash commits and push'
  if [ (count $argv) = 0 ]
    echo -e "\033[0;32m\$argv[1] is missing, type the base branch name\033[0m"
    return
  end
  if [ (count $argv) = 1 ]
    echo -e "\033[0;32m\$argv[2] is missing, type the branch name for squashing\033[0m"
    return
  end
  if [ (count $argv) = 2 ]
    echo -e "\033[0;32m\$argv[3] is missing, type the commit message\033[0m"
    return
  end
  echo -e base branch: "\033[0;32m$argv[1]\033[0m"
  echo -e squashing branch: "\033[0;32m$argv[2]\033[0m"
  echo -e commit message: "\033[0;32m$argv[3]\033[0m"
  git checkout -b $argv[2]
  git branch -D tmp
  git checkout -b tmp
  git branch -D $argv[2]
  git checkout $argv[1]
  git checkout -b $argv[2]
  git merge tmp --squash
  git commit -m $argv[3]
  git push origin $argv[2] -f
end

function hugonew --description 'hugo new and create static/image/xx/ directory'
  mkdir -p static/img/$argv[1]
  hugo new $argv[1].md
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

function peco_history --description 'search previously used command through peco'
  history --search --contains $argv[1] | peco
end
