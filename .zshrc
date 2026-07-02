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
  zsh-syntax-highlighting
)

export ZSH=$HOME/.oh-my-zsh

# remove end-of-line (ctrl+e) from autosuggest accept triggers; keep forward-char (right arrow)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char vi-forward-char vi-end-of-line vi-add-eol)

source $ZSH/oh-my-zsh.sh

###
# Give `ls` a serious upgrade
hash gls >/dev/null 2>&1 || alias gls="ls"
# always use color (including piping)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

DISABLE_AUTO_TITLE="true"

# ── Shell color theme ────────────────────────────────────────────────
# Themes live in ~/.config/shell-themes/<name>/ (base16.sh + fzf.sh + statusline.sh).
# Switch everything at once — shell + fzf + Claude Code + iTerm2 profile — with:
#     theme <name>        e.g.  theme oceanic  |  theme biolume
#     theme               list available + show current
# Preserved original: `oceanic` (Oceanic Next). Active theme -> $SHELL_THEMES_DIR/active
export SHELL_THEMES_DIR="$HOME/.config/shell-themes"
_active_theme="$(cat "$SHELL_THEMES_DIR/active" 2>/dev/null || echo oceanic)"
[[ -s "$SHELL_THEMES_DIR/$_active_theme/base16.sh" ]] && source "$SHELL_THEMES_DIR/$_active_theme/base16.sh"
[[ -s "$SHELL_THEMES_DIR/theme.zsh" ]] && source "$SHELL_THEMES_DIR/theme.zsh"

# fzf opts — palette follows the active shell theme
[[ -s "$SHELL_THEMES_DIR/$_active_theme/fzf.sh" ]] && source "$SHELL_THEMES_DIR/$_active_theme/fzf.sh"
source <(fzf --zsh)
unset _active_theme

# bat (replace cat)
# alias cat="bat --paging=never"

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

# Complex prompts resize correctly by allowing the shell to redraw -- rather than reflow -- the prompt line.
TRAPWINCH() {
  zle && zle reset-prompt
}

PROMPT=" %F{cyan}%T%f $PROMPT"

_copy-git-branch() { git branch --show-current 2>/dev/null | tr -d '\n' | pbcopy }
zle -N _copy-git-branch
bindkey $'\x1b[98;17u' _copy-git-branch



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


alias claude='~/.local/bin/claude --model="opus"'

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

stopwatch() {
  TIMEFMT="%*Es"; time (read)
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

# cd to a worktree by name, regardless of which repo it lives under
# usage: wd <worktree-name>   (bare `wd` jumps to the worktrees root)
wd() {
  local base="$HOME/projects/.worktrees"
  [[ -z "$1" ]] && { cd "$base"; return }
  local matches=("$base"/*/"$1"(/N))
  case ${#matches} in
    0) echo "wd: no worktree named '$1' under $base" >&2; return 1 ;;
    1) cd "${matches[1]}" ;;
    *) echo "wd: '$1' matches multiple repos:" >&2
       print -l -- ${matches#$base/} >&2; return 1 ;;
  esac
}
_wd_completion() {
  reply=($(cd "$HOME/projects/.worktrees" 2>/dev/null && ls -1d */*/ 2>/dev/null | sed 's#.*/\([^/]*\)/$#\1#' | sort -u))
}
compctl -K _wd_completion wd

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

CURSOR_CLI_BIN="$HOME/.local/bin"
export PATH="$CURSOR_CLI_BIN:$COREUTILSBIN:$FINDUTILSBIN:$GNUSEDBIN:$STACKER_HOME:$PATH:/Applications/IntelliJ IDEA.app/Contents/MacOS"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home

# zprof

# pnpm
export PNPM_HOME="/Users/joshuaclark/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source ~/.config/default.env
