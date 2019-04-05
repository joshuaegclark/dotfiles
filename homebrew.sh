#!/usr/bin/env bash

#
# Heavily influenced by (read: copy/pasta)
# and adapted from https://github.com/paulirish/dotfiles
#

bash ./install-homebrew.sh

# Brew
## Update Homebrew and any already installed formulae
brew update && brew upgrade
brew install caskroom/cask/brew-cask
# to maintain cask:
# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# deprecated - brew tap homebrew/versions
brew tap caskroom/versions

## GNU core utilities (OS X ships with outdated ones)
## `$(brew --prefix coreutils)/libexec/gnubin` is added
## to `$PATH` in .zshrc.
brew install coreutils
brew install moreutils

## GNU find, locate, updatedb, and xargs
brew install findutils

## GNU sed, overwrites built-in sed
brew install gnu-sed --with-default-names

## Install more recent version of some OS X tools
brew install vim # this option wasn't recognized: --overide-system-vi
brew install homebrew/homebrew-core/grep
brew install homebrew/homebrew-core/screen
brew install homebrew/homebrew-core/openssh

brew install watch
brew install git
brew install zsh

# gradlew `gw` shorthand
brew install gdub

## Better git diffs!
brew install diff-so-fancy

# Casks (Native Applications)

## Dev
brew cask install hyper
brew cask install visual-studio-code
brew cask install atom

## browsers
brew cask install google-chrome
brew cask install google-chrome-canary
#brew cask install firefox-nightly
#brew cask install webkit-nightly
#brew cask install torbrowser
#brew cask install chromium

## General
brew cask install spectacle
brew cask install flux
#brew cask install vlc

brew cleanup
