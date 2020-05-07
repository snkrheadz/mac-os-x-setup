#!/bin/bash

# exit if xcode is not installed
if ! which -s xcode-select; then
  echo 'Open AppStore and install XCode before you set up your MacBook'
  echo 'Run following commands after XCode installed'
  echo ''
  # echo 'sudo xcode build -license'
  echo 'xcode-select --install'
  return
fi

# install Homebrew
if ! which -s brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# load packages
. brew_packages.sh

brew tap homebrew/cask
brew tap thoughtbot/formulae

# install pakages
for package in $BREW_PACKAGES; do
  # brew install $package
  if brew list -1 | grep -q "^$(basename $package)"; then
    echo "Skip: brew install ${package}"
  else
    brew install $package
  fi
done

# install ohmyzsh
if ! [ -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# remove .zshrc* due to use .zshrc from dotfiles
if [ -f ~/.zshrc ]; then rm .zshrc; fi
if [ -f ~/.zshrc.pre-oh-my-zsh ]; then rm ~/.zshrc.pre-oh-my-zsh; fi

# install fisherman
if ! [ -f ~/.config/fish/functions/fisher.fish ]; then
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fi

# install dotfiles
if [ ~/dotfiles ]; then mv ~/dotfiles ~/dotfiles-$(date "+%Y-%m-%d-%H-%M-%S"); fi
git clone git://github.com/akinrt/dotfiles.git ~/dotfiles
git clone git://github.com/akinrt/dotfiles-local.git ~/dotfiles-local
chmod 0755 $HOME/dotfiles/hooks/post-up
env RCRC=$HOME/dotfiles/rcrc rcup

# run playbook
ansible-playbook -i inventory/localhost localhost.yml

if ! [ `cat /etc/shells | grep '/usr/local/bin/fish'` ]; then
  echo '/usr/local/bin/fish' >> /etc/shells
fi

chsh -s /usr/local/bin/fish

fisher add decors/fish-ghq edc/bass fisherman/getopts fisherman/rbenv fisherman/z oh-my-fish/plugin-peco oh-my-fish/theme-godfather
