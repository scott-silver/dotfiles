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
alias hack='git pull origin master'
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
# alias vim="mvim -v"

# ==============================================================================
# personal quotation device
# ==============================================================================

alias mpr="./mpr --team=CAPITAL --label=capital"

# ==============================================================================
# spacesmacs
# ==============================================================================

alias spacemacs="emacs"

alias reindex_spotlight="sudo mdutil -E /"

# ==============================================================================
# flexport aliases
# ==============================================================================

#flexport backend
# use 'foreman start -f Procfile.dev' if you want delayed job and mailhog to work
# otherwise, use 'bundle exec rails server thin -p 3000' if you want byebug to work
alias fb='bundle exec rails server thin -p 3000'

alias renew_ssh_key='ssh-add'

alias flexport_shared='rm -rf node_modules/flexport-shared && cp -r client/shared/ node_modules/flexport-shared'

# server-side rendering aliases
alias ssr='rm -rf public/packs/ && node --max_old_space_size=8192 ~/flexport/node_modules/.bin/webpack --config ./webpack/config.dev.js && SSR=1 foreman start -f Procfile.dev'
alias ssr_server='SSR=1 foreman start -f Procfile.dev'

alias copy_git_branch='git rev-parse --abbrev-ref HEAD | pbcopy'

alias prune_git_branches='git fetch --prune origin'

alias kill_server='kill -9 "$(cat /Users/scottsilver/flexport/tmp/pids/server.pid)"'

# open man page in preview (todo: pass in command as arg)
alias open_in_preview='man -t bash | open -f -a /Applications/Preview.app'

alias reload_database='./script/devbox.rb load_db --local'

# https://stackoverflow.com/questions/7975556/how-to-start-postgresql-server-on-mac-os-x
alias start_postgres='pg_ctl -D /usr/local/var/pos'
alias restart_postgres='brew services restart postgresql' # https://stackoverflow.com/a/30841396
