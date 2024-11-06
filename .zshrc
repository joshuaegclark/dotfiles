# oh-my-zsh stuff for reference
# set theme to empty for 
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""
plugins=(
  git
)

alias .rc="source $HOME/.zshrc"
alias rc="vim $HOME/.zshrc"
alias vi="vim"
alias gs="git status"
alias gl="git log"
# OLD, fucky in broadcom office, but fine otherwise
# alias ip="ifconfig | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias ip="ifconfig $(networksetup -listnetworkserviceorder | grep 'Wi-Fi, Device' | sed -E "s/.*(en[0-9]).*/\1/") | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias iplan="ifconfig $(networksetup -listnetworkserviceorder | grep -E '(Ethernet|LAN), Device' | sed -E "s/.*(en[0-9]).*/\1/") | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias npm-reset-deps="rm -rf node_modules && rm -f package-lock.json && npm cache verify && npm i"

# count the number of lines in all files in a repo
alias lines="git diff --shortstat `git hash-object -t tree /dev/null`"
alias local-smtp-server="sudo python -m smtpd -n -c DebuggingServer localhost:25"
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
alias deps="npm run deps && git restore package-lock.json"

# Utility Functions
difff() {
  diff -u "$1" "$2" | diff-so-fancy
}

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

CYAN="\033[36m"
NC="\033[0m" # No Color

do-times() {
  COMMAND=${@:2}
  echo "${CYAN}Running command: $COMMAND${NC}"
  echo "${CYAN}Executing $1 times...${NC}"
  for run in {1..$1}
  do
    echo "${CYAN}==========Run $run==========${NC}"
    # Simply running $COMMAND and the bash alternative do no work
    # correctly for commands with spaces/args
    # so instead using the slightly more dangerous `eval`.
    # https://unix.stackexchange.com/questions/444946/how-can-we-run-a-command-stored-in-a-variable
    #     bash -c $COMMAND
    eval $COMMAND
  done

  echo "${CYAN}==========Fín==========${NC}"
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
  git clone https://github.com/RallySoftware/$1.git ${@:2}
}
josh-clone() {
  git clone https://github.com/joshuaegclark/$1.git ${@:2}
}

almDeleteGradleLocks() {
    find $HOME/projects/alm/.gradle -name "*.lock" -type f -delete |  find /Users/joshuaclark/projects/alm/buildSrc/.gradle -name "*.lock" -type  f -delete | find /Users/joshuaclark/.gradle -name "*.lock" -type f -delete
}

almRunLocalChurro() {
  gw zuul kafka churro churroGateway jR
}

testn () {
  mkdir -p /tmp/testn/$1
  rm -f /tmp/testn/$1/config
  wget -P /tmp/testn/$1/ https://home-${1}.testn.f4tech.com/kubeconfig/config
  k9s --kubeconfig /tmp/testn/$1/config
}

DISABLE_AUTO_TITLE="true"

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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://github.com/sindresorhus/pure
# Must do `npm i -g pure-prompt` to install
# init
fpath+=($HOME/.zsh/pure)
autoload -Uz promptinit; promptinit

# customize
prompt_newline='%667v' # single line prompt
# uncomment NODEPROMPT and use PROMPT below it to show node version
# does not update if node version changes until a new shell session is
# started
# NODEPROMPT="$FG[154]⬢ %{$reset_color%}$FG[158]%v`node -v`%{$reset_color%}"
# PROMPT=" %F{cyan}%* %{$reset_color%}($NODEPROMPT) $PROMPT"

#PROMPT=" %T{cyan}%* %{reset_color%} $PROMPT"
prompt pure
# PROMPT=" $PROMPT" # single line prompt
# PROMPT="%T $PROMPT"
PROMPT=" %F{cyan}%T%f $PROMPT"
# PROMPT='%F{white}%* '$PROMPT # show system time
# PROMPT=" %F{white}%* $PROMPT" # single line prompt + system time

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

## History command configuration
## TODO: these configs may be redundant here, investigate
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Make delete key not kill my terminal session
set -o ignoreeof 3

# GNU core utilities (OS X ships with outdated ones)
COREUTILSBIN="/usr/local/opt/coreutils/libexec/gnubin"
FINDUTILSBIN="/usr/local/opt/findutils/libexec/gnubin"
GNUSEDBIN="/usr/local/opt/gnu-sed/libexec/gnubin"

# This was needed as of November 6th 2024 in order for ALM docker related things to work
export DOCKER_DEFAULT_PLATFORM=linux/x86_64/v8
export PATH="$COREUTILSBIN:$FINDUTILSBIN:$GNUSEDBIN:$STACKER_HOME:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
