# oh-my-zsh stuff for reference
# set theme to empty for 
ZSH_THEME=""
plugins=(
  git
)

alias .rc="source $HOME/.zshrc"
alias rc="vim $HOME/.zshrc"
alias vi="vim"
alias gs="git status"
alias gl="git log"
alias ip="ifconfig | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
# count the number of lines in all files in a repo
alias lines="git diff --shortstat `git hash-object -t tree /dev/null` > lines.txt && cat lines.txt && rm lines.txt"
# `git old` will do this as well 
alias show-branch-ages="git for-each-ref refs/remotes/origin/ --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

###
# Give `ls` a serious upgrade
hash gls >/dev/null 2>&1 || alias gls="ls"
# always use color (including piping)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

alias ls="gls -AFh ${colorflag} --group-directories-first"
alias lsd='ls -l | grep "^d"' # only directories
alias ll="ls -l"
alias l="gls -aFh ${colorflag} --group-directories-first"
alias ij="idea"
alias ..="cd .."

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

function proj() {
  cd ~/projects/$1
}
_proj_completion() {
  reply=($(exec ls -m ~/projects | sed -e 's/,//g' | tr -d '\n'))
}
compctl -K _proj_completion proj
alias p="proj"

rally-clone() {
  git clone https://github.com/RallySoftware/$1.git
}
josh-clone() {
  git clone https://github.com/joshuaegclark/$1.git
}

# oceanic next shell theme
# https://github.com/mhartington/oceanic-next-shell
# must do the following first to install:
# git clone https://github.com/mhartington/oceanic-next-shell.git ~/.config/oceanic-next-shell
#
# Base16 Shell
BASE16_SHELL="$HOME/.config/oceanic-next-shell/oceanic-next.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Load nvm before setting up the prompt to avoid
# race condition when getting node version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# https://github.com/sindresorhus/pure
# Must do `npm i -g pure-prompt` to install
# init
autoload -U promptinit; promptinit
prompt pure
# customize
prompt_newline='%666v' # single line prompt
# PROMPT=" $PROMPT" # single line prompt
# PROMPT='%F{white}%* '$PROMPT # show system time
# PROMPT=" %F{white}%* $PROMPT" # single line prompt + system time
NODEPROMPT="$FG[154]⬢ %{$reset_color%}$FG[158]%v`node -v`%{$reset_color%}"
PROMPT=" %F{cyan}%* %{$reset_color%}($NODEPROMPT) $PROMPT" 

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Make delete key not kill my terminal session
set -o ignoreeof 3

# GNU core utilities (OS X ships with outdated ones)
COREUTILSBIN="/usr/local/opt/coreutils/libexec/gnubin"
FINDUTILSBIN="/usr/local/opt/findutils/libexec/gnubin"
GNUSEDBIN="/usr/local/opt/gnu-sed/libexec/gnubin"
export PATH="$COREUTILSBIN:$FINDUTILSBIN:$GNUSEDBIN:$PATH"

