# oh-my-zsh stuff for reference
# Uncomment this line and the zprof line at the end of this file to enable profiling
# then you can run `time zsh -i -c exit`
# zmodload zsh/zprof

# This mode defers the load of the nvm plugin and activates the script when using it
# zstyle ':omz:plugins:nvm' lazy yes
# This will only source the plugin in directories that contain a .nvmrc file
zstyle ':omz:plugins:nvm' autoload yes

zstyle ':omz:plugins:zsh-sdkman' lazy yes

ZSH_THEME=""
# to install sdkman plugin: git clone https://github.com/ptavares/zsh-sdkman.git ~/.oh-my-zsh/custom/plugins/zsh-sdkman
plugins=(
  git
  nvm
  zsh-sdkman
)

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

###
# Give `ls` a serious upgrade
hash gls >/dev/null 2>&1 || alias gls="ls"
# always use color (including piping)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

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
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://github.com/sindresorhus/pure
# Must do `npm i -g pure-prompt` to install
# init
fpath+=($HOME/.zsh/pure)
autoload -Uz promptinit; promptinit

# customize
# IT WAS THIS ONE I COMMENTED
prompt_newline='%667v' # single line prompt

# uncomment NODEPROMPT and use PROMPT below it to show node version
# does not update if node version changes until a new shell session is
# started
# NODEPROMPT="$FG[154]⬢ %{$reset_color%}$FG[158]%v`node -v`%{$reset_color%}"
# PROMPT=" %F{cyan}%* %{$reset_color%}($NODEPROMPT) $PROMPT"

#PROMPT=" %T{cyan}%* %{reset_color%} $PROMPT"

# THIS ONE
prompt pure
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

# Jan 22, 2025 - disabled this and everything appears to work fine?
# Make delete key not kill my terminal session
# set -o ignoreeof 3


alias .rc="source $HOME/.zshrc"
alias rc="vim $HOME/.zshrc"
alias vi="vim"
alias gs="git status"
alias gl="git log"
# OLD, fucky in broadcom office, but fine otherwise
# alias ip="ifconfig | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias ip="ifconfig $(networksetup -listnetworkserviceorder | grep 'Wi-Fi, Device' | sed -E "s/.*(en[0-9]).*/\1/") | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias iplan="ifconfig $(networksetup -listnetworkserviceorder | grep -E '(Ethernet|LAN), Device' | sed -E "s/.*(en[0-9]).*/\1/") | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"

# count the number of lines in all files in a repo
# alias lines="git diff --shortstat `git hash-object -t tree /dev/null`"
alias lines="git ls-files '*.js' '*.jsx' | xargs cat | wc -l"
alias local-smtp-server="sudo python -m smtpd -n -c DebuggingServer localhost:25"
# `git old` will do this as well
alias show-branch-ages="git for-each-ref refs/remotes/origin/ --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias ls="gls -AFh ${colorflag} --group-directories-first"
alias lsd='ls -l | grep "^d"' # only directories
alias ll="ls -l"
alias l="gls -aFh ${colorflag} --group-directories-first"
alias ij="idea"
alias ..="cd .."
alias deps="pnpm deps"

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

qt-int() {
  pnpm test:integration --exact=$1
}

qt-unit() {
  pnpm test:unit --exact=$1
}

t-int() {
  pnpm test:integration --dev --exact=$1
}

t-unit() {
  pnpm test:unit --dev --exact=$1
}

e2e() {
  NODE_TLS_REJECT_UNAUTHORIZED=0 ALM_URL=https://localhost:$1 pnpm e2e $2
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
  git clone https://github.gwd.broadcom.net/ESD/$1.git ${@:2}
}
josh-clone() {
  git clone https://github.com/joshuaegclark/$1.git ${@:2}
}

almDeleteGradleLocks() {
    find $HOME/projects/rally-alm/.gradle -name "*.lock" -type f -delete |  find /Users/joshuaclark/projects/rally-alm/buildSrc/.gradle -name "*.lock" -type  f -delete | find /Users/joshuaclark/.gradle -name "*.lock" -type f -delete
}

almRunLocalChurro() {
  gw zuul kafka churro churroGateway jR
}

# GNU core utilities (OS X ships with outdated ones)
COREUTILSBIN="/usr/local/opt/coreutils/libexec/gnubin"
FINDUTILSBIN="/usr/local/opt/findutils/libexec/gnubin"
GNUSEDBIN="/usr/local/opt/gnu-sed/libexec/gnubin"

# This was needed as of November 6th 2024 in order for ALM docker related things to work
export DOCKER_DEFAULT_PLATFORM=linux/x86_64/v8
export PATH="$COREUTILSBIN:$FINDUTILSBIN:$GNUSEDBIN:$STACKER_HOME:$PATH:/Applications/IntelliJ IDEA.app/Contents/MacOS"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home

# #compdef pnpm
# ###-begin-pnpm-completion-###
# if type compdef &>/dev/null; then
#   _pnpm_completion () {
#     local reply
#     local si=$IFS
#
#     IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
#     IFS=$si
#
#     if [ "$reply" = "__tabtab_complete_files__" ]; then
#       _files
#     else
#       _describe 'values' reply
#     fi
#   }
#   # When called by the Zsh completion system, this will end with
#   # "loadautofunc" when initially autoloaded and "shfunc" later on, otherwise,
#   # the script was "eval"-ed so use "compdef" to register it with the
#   # completion system
#   if [[ $zsh_eval_context == *func ]]; then
#     _pnpm_completion "$@"
#   else
#     compdef _pnpm_completion pnpm
#   fi
# fi
# ###-end-pnpm-completion-###


# zprof

# pnpm
export PNPM_HOME="/Users/joshuaclark/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
