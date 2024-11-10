#!/usr/bin/env bash

# TODO move me into .functions or util
print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

# Begin setup
echo "Please enter your github username. Press enter to skip."
read -r GITHUB_USERNAME

echo "Please enter your github email address. Press enter to skip."
read -r GITHUB_EMAIL_ADDRESS

# Install Homebrew and formulae and native applications via cask
bash ./homebrew.sh

# Run homebrew setup first so diff-so-fancy is installed prior to configuring git to use it
./git-config-setup.sh "$GITHUB_USERNAME" "$GITHUB_EMAIL_ADDRESS"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install shell color theme
# See corresponding config in .zshrc under "oceanic next shell theme"
git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell

# Link all dotfiles to home
bash ./link-dotfiles.sh

# XCode Command Line Tools
# https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

# Install NVM, ought to check the version here. Much dislike for version in url... >_>
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

# Show hidden files in macOS
defaults write com.apple.finder AppleShowAllFiles YES
