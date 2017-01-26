#!/bin/bash

alias be="bundle exec"
alias la="ls -a"

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

# ==============================================================================
# vim
# ==============================================================================

# use macvim in terminal
alias vim="mvim -v"
