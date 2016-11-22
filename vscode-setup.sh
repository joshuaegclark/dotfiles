#!/usr/bin/env bash

installExtension() {
  code --install-extension $1
}

createSymlink() {
  if [ "$2" ]; then
      rm -rf "$2"
  fi
  ln -s "$1" "$2"
  echo "Created symlink to $1"
}

createCodeSymlink() {
  createSymlink `pwd`/vscode/$1 ~/Library/Application\ Support/Code/User/$1
}

createCodeSymlink settings.json
createCodeSymlink keybindings.json
# Trash existing snippets directory
# TODO: write a recursive symlink to link the contents of ./vscode/snippets
rm -rf "$HOME/Library/Application\ Support/Code/User/snippets"
createCodeSymlink snippets

installExtension ms-vscode.atom-keybindings
installExtension avli.clojure
installExtension PeterJausovec.vscode-docker
installExtension dbaeumer.vscode-eslint
installExtension rtorr.vscode-flow
