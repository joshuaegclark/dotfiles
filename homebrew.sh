#!/usr/bin/env bash

#
# Heavily influenced by (read: copy/pasta)
# and adapted from https://github.com/paulirish/dotfiles
#

bash ./install-homebrew.sh

# Brew
## Update Homebrew and any already installed formulae
brew update && brew upgrade
brew install homebrew/cask/brew-cask
# to maintain cask:
# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

brew tap homebrew/cask-versions

## GNU core utilities (OS X ships with outdated ones)
## `$(brew --prefix coreutils)/libexec/gnubin` is added
## to `$PATH` in .zshrc.
brew install coreutils
brew install moreutils

## GNU find, locate, updatedb, and xargs
brew install findutils

## GNU sed, overwrites built-in sed
brew install gnu-sed

# macs ship with an ancient version of rsync, so install latest
brew install rsync

## Install more recent version of some OS X tools
brew install vim # this option wasn't recognized: --overide-system-vi
brew install homebrew/homebrew-core/grep
brew install homebrew/homebrew-core/screen
brew install homebrew/homebrew-core/openssh

brew install watch
brew install git
brew install leiningen
brew install zsh

# gradlew `gw` shorthand
brew install gdub

## Better git diffs!
brew install diff-so-fancy

# Casks (Native Applications)
## browsers
#brew cask install google-chrome
#brew cask install google-chrome-canary

## General
brew install --cask spectacle
brew install --cask flux

brew cleanup
