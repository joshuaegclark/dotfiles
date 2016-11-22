#this is defined in .oh-my-zsh/lib!
alias ll="ls -lah"
alias l="ls -lh"
alias .rc="source $HOME/.zshrc"
alias rc="vim $HOME/.zshrc"
alias vi="vim"
alias gs="git status"
alias gl="git log"
alias amend="git commit --amend --no-edit --reset-author"
# TODO: Figure out why this alias executes and gives not a repo error
# when sourcing .zshrc
# alias repo-top="git rev-parse --show-top-level"
# alias rt="cd $(repo-top)"
alias ip="ifconfig | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias countlines="git diff --shortstat `git hash-object -t tree /dev/null`"
alias lines="countlines > lines.txt && cat lines.txt && rm lines.txt"
# `git old` will do this as well 
alias show-branch-ages="git for-each-ref refs/remotes/origin/ --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# Load scripts
## https://github.com/rupa/z.git
. ~/z/z.sh

## Node Version Manager
export NVM_DIR="/Users/joshuaclark/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Utility Functions
findir() {
  find ~ -type d -name $1 -print
}

killport() {
  echo Killing anything listening on port $1\.\.\.
  kill -9 $(lsof -t -iTCP:$1 -sTCP:LISTEN) 2>/dev/null
} 

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# GNU core utilities (OS X ships with outdated ones)
#export PATH="$PATH:`$(brew --prefix coreutils)/libexec/gnubin`"

# TODO: wire up completion
function proj() {
  cd ~/projects/$1
}
