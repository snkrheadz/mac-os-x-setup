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

# install pakages
for package in $BREW_PACKAGES; do
  # brew install $package
  if brew list -1 | grep -q "^$(basename $package)"; then
    echo "Skip: brew install ${package}"
  else
    brew tap thoughtbot/formulae
    brew install $package
  fi
done

# install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# install dotfiles
git clone git://github.com/thoughtbot/dotfiles.git ~/dotfiles
. ~/dotfiles/hooks/post-up

# run playbook
ansible-playbook site.yml
