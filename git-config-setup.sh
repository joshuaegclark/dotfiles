#!/usr/bin/env bash

GITHUB_USERNAME=$1
GITHUB_EMAIL_ADDRESS=$2

if [ -z "$GITHUB_USERNAME" ]; then
  echo "Github username not set, skipping.";
else
  echo "Setting global git user.name to: '$GITHUB_USERNAME'";
  git config --global user.name "$GITHUB_USERNAME"
fi

if [ -z "$GITHUB_EMAIL_ADDRESS" ]; then
  echo "Github email address not set, skipping.";
else
  echo "Setting global git user.email to: '$GITHUB_EMAIL_ADDRESS'";
  git config --global user.email "$GITHUB_EMAIL_ADDRESS"
fi

echo "Setting up general git config options and aliases..."

# general
git config --global branch.autosetuprebase always
git config --global push.default simple
git config --global merge.conflictstyle diff3
git config --global core.editor vim
git config --global fetch.prune true
git config --global pull.rebase true

#aliases
git config --global alias.old "for-each-ref refs/remotes/origin/ --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
git config --global alias.incoming "!git remote update -p; git log ..@{u}"
git config --global alias.outgoing "log @{u}.."
git config --global alias.recent-branches "for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/"
git config --global alias.rb "recent-branches"
git config --global alias.df "diff -- .':(exclude)*package-lock.json'"
git config --global alias.discard "! git stash -q --include-untracked && git stash drop -q"

# diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui always
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta "11"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "yellow bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
git config --global color.branch.current "yellow reverse"
git config --global color.branch.local "yellow"
git config --global color.branch.remote "green"
git config --global color.status.added "green"
git config --global color.status.changed "yellow bold"
git config --global color.status.untracked "cyan bold"

echo "Git configuration complete."
