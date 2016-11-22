#!/usr/bin/env bash

#
# Heavily influenced by (read: copy/pasta)
# and adapted from https://github.com/paulirish/dotfiles
#

bash ./install-homebrew.sh

# Brew
## Update Homebrew and any already installed formulae
brew update && brew upgrade
brew tap homebrew/versions

## GNU core utilities (OS X ships with outdated ones)
## `$(brew --prefix coreutils)/libexec/gnubin` is added
## to `$PATH` in .zshrc.
brew install coreutils
brew install moreutils

## GNU find, locate, updatedb, and xargs
brew install findutils

## GNU sed, overwrites built-in sed
brew install gnu-sed --default-names

## Install more recent version of some OS X tools
brew install vim --overide-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen
brew install homebrew/dupes/openssh

brew install git
brew install zsh

## Better git diffs!
brew install diff-so-fancy

# Casks (Native Applications)
brew install caskroom/cask/brew-cask
# to maintain cask:
# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup


# Dev
brew cask install hyper
brew cask install visual-studio-code
brew cask install atom


## browsers
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install firefox-nightly
brew cask install webkit-nightly
brew cask install torbrowser
brew cask install chromium

# General
brew cask install spectacle
brew cask install flux
brew cask install vlc

brew cleanup
brew cask cleanup