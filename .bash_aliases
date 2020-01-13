#!/bin/bash

alias be="bundle exec"
alias la="ls -a"
alias reindex_spotlight="sudo mdutil -E /"

# ==============================================================================
# chrome
# ==============================================================================

alias chrome="open -a 'Google Chrome'"

# ==============================================================================
# git aliases
# ==============================================================================

# source bash_completion
# http://stackoverflow.com/questions/14970728/homebrew-s-git-not-using-completion/14970926#14970926
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# source git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

function git_branch() {
  git rev-parse --abbrev-ref HEAD
}

alias gb="git branch"
alias gcb="git checkout -b"
alias gco="git checkout"
__git_complete gco _git_checkout
alias gd="git diff"
alias gs="git status"
alias hack='git pull'
alias ship='git push -u origin $(git_branch)'

# open github's pr site with the current repo and branch
# http://www.devthought.com/code/create-a-github-pull-request-from-the-terminal/
function gpr () {
  local repo=`git remote -v | grep -m 1 "(push)" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"`
  local branch=`git name-rev --name-only HEAD`
  echo "... creating pull request for branch \"$branch\" in \"$repo\""
  open https://github.com/$repo/pull/new/$branch
}

export -f gpr

# ==============================================================================
# vim
# ==============================================================================

# use macvim in terminal
alias vim="mvim -v"
