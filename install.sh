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
    brew tap homebrew/cask
    brew tap thoughtbot/formulae
    brew install $package
  fi
done

# install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# install dotfiles
git clone git://github.com/akinrt/dotfiles.git ~/dotfiles
chmod 0755 $HOME/dotfiles/hooks/post-up
ln -s $HOME/dotfiles/dotfiles-local $HOME/dotfiles-local
env RCRC=$HOME/dotfiles/rcrc rcup

# run playbook
ansible-playbook -i inventories/localhost/hosts site.yml

echo '/usr/local/bin/fish' >> /etc/shells
chsh -s /usr/local/bin/fish

fisher edc/bass fisherman/getopts oh-my-fish/theme-godfather oh-my-fish/plugin-peco yoshiori/fish-peco_select_ghq_repository fisherman/rbenv fisherman/z
