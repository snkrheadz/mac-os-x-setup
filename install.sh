#!/bin/bash

# Exit if xcode is not installed
if ! which -s xcode-select; then
  echo 'Open AppStore and install XCode before you set up your MacBook'
  echo 'Run following commands after XCode installed'
  echo ''
  echo 'sudo xcode build -license'
  echo 'xcode-select --install'
  return
fi

# Load Packages
. brew_packages.sh

# Install Homebrew
if ! which -s brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Pakages
for package in $BREW_PACKAGES; do
  # brew install $package
  if brew list -1 | grep -q "^$(basename $package)"; then
    echo "Skip: brew install ${package}"
  else
    brew install $package
  fi
done

# Install NeoBundle
if ! [ -e ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Install Oh My fish
if ! which -s omf; then
  curl -L http://get.oh-my.fish | fish
fi

# Run playbook
ansible-playbook site.yml

# update atom
apm stars --user akinrt --install

# Restart shell as fish?
# Default shell has been changed by ansible-playbook, open new window to use updated version

# Install avn / Automatic Node Version Switching
# https://www.npmjs.com/package/avn
# someday if nvm support fish shell :)
# npm install -g avn avn-nvm avn-n
# avn setup