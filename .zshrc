alias ip="ifconfig | grep 'inet 10' | sed 's/.* \([0-9\.]*\) .*/\1/'"
alias nr="npm run"
alias countlines="git diff --shortstat `git hash-object -t tree /dev/null`"
alias lines="countlines > lines.txt && cat lines.txt && rm lines.txt"
alias show-branch-ages="git for-each-ref refs/remotes/origin/ --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias pun="rm -rf node_modules/ && npm install && npm run build:clean"

killport() {
  echo Killing anything listening on port $1\.\.\.
  kill -9 $(lsof -t -iTCP:$1 -sTCP:LISTEN) 2>/dev/null
}

# ueshell() {
#   if [[ $1 =~ '^[0-9]+$' ]]
#   then
#     cluster=$1
#   else
#     cluster="https://$1.testn.f4tech.com"
#   fi
#   bur && npm run shell $cluster ~/projects/churro
# }

function proj() {
  cd ~/projects/$1
}
