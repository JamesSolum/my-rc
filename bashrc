# Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Aliases
alias r='reset'
alias rm='rm -i' # prompt before deleting
alias c='clear'
alias grep="grep --color"
alias .='pwd'
alias ..='cd ../'
alias ...='cd ../../'
alias eb='vim ~/.bashrc' 
alias ev='vim ~/.vimrc'
alias sb='source ~/.bashrc' 
alias sbp='source ~/.bash_profile'
alias rubo-check='git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop'
alias rubo-correct='git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop --auto-correct'
alias g='git' # git alias
alias gps='git push'
alias gpl='git pull'
alias grh='git reset --hard'
alias gco='git checkout'

# Add git to cd path
CDPATH=$CDPATH:~/git/

# Display git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Command prompt
export PS1=" \[\033[36m\]\u \[\033[33m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ " # Prompt w/ pwd and git branch

# Set Vi Mode
set -o vi
bind 'set show-mode-in-prompt on' # needs updated bash if on mac

# Use ripgrep for fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fco - checkout git branch/tag
fCo() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fbr - checkout git branch
fco() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf-tmux +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Custom settings
source ~/.custom_bash_config

# Git Config 
source ~/.custom_system_vars
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_EMAIL"


# For fzf stuff
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
