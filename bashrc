# Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Aliases
alias ls='ls -GFh --color=auto'
alias ll='ls -lG --color=auto'
alias a='alias'
alias r='reset'
alias rm='rm -i' # prompt before deleting
alias c='clear'
alias grep="grep --color"
alias .='pwd'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias eb='vim ~/.bashrc' # Make sure to change to bashrc for linux
alias ev='vim ~/.vimrc'
alias sb='source ~/.bashrc' # Make sure to change for Linux
alias rubo-check='git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop'
alias rubo-correct='git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop --auto-correct'
alias g='git' # git alias
alias gp='git push'

# Display git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Different versions of command prompt
#export PS1="[\u@\[\033[36m\]\h\[\033[33m\] \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]]\$ " #Prompt with git branch and $
#export PS1=" \[\033[36m\]\u \[\033[33m\]\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] >> " # Prompt with git branch and >>
export PS1=" \[\033[36m\]\u \[\033[33m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ " # Prompt w/ pwd and git branch

# Set Vi Mode
set -o vi
bind 'set show-mode-in-prompt on' # needs updated bash if on mac

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
