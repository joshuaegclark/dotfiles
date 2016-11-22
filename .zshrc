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
alias brew-update="brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup"

###
# time to upgrade `ls`

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls="gls -AFh ${colorflag} --group-directories-first"
alias lsd='ls -l | grep "^d"' # only directories
###
#this is defined in .oh-my-zsh/lib!
alias ll="ls"
alias l="gls -aFh ${colorflag} --group-directories-first"


# Load scripts
## https://github.com/rupa/z.git
. ~/z/z.sh

## Node Version Manager
export NVM_DIR="/Users/joshuaclark/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Utility Functions
find-alias() {
  grep -r "$1" "$2"
}

findir() {
  find ~ -type d -name $1 -print
}

killport() {
  echo Killing anything listening on port $1\.\.\.
  kill -9 $(lsof -t -iTCP:$1 -sTCP:LISTEN) 2>/dev/null
} 

# TODO: wire up completion
function proj() {
  cd ~/projects/$1
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

