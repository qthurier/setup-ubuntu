# scmpuff adds the following aliases with nice colours and number shortcuts next to changed files:
# alias gs='scmpuff_status'
# alias ga='git add'
# alias gd='git diff'
# alias gl='git log'
# alias gco='git checkout'
# alias grs='git reset' # ie: unstage
eval "$(scmpuff init -s)"

# taken from scm breeze https://github.com/scmbreeze/scm_breeze/blob/master/lib/git/aliases.sh
alias gc='git commit'
alias gcm='git commit --amend'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gla='gl --all'
alias gdc='git diff --cached'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gcb='git checkout -b'
alias gsh='git show'

# other
alias gdh='git diff "HEAD^" HEAD'
# show both staged and unstaged changes
alias gda='git diff HEAD'
# add everything except untracked files
alias gaa='git add -u'
