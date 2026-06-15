# starship
eval "$(starship init zsh)"

# history
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history
setopt share_history

# aliases
alias rm="rm -i"
alias la="ls -a"

## git
alias gcob='git checkout -b'
alias gco='git checkout'
alias gps='git push'
alias gpl='git pull'
alias gc='git commit -m'
alias branch='git branch -a | grep -v "HEAD ->" | sed "s|^[*+ ] *||; s|^remotes/origin/||" | awk "!seen[\$0]++" | fzf --height=20% --reverse --info=inline | xargs git checkout'

## bat
alias c='bat'

## eza
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --git --group-directories-first'
alias la='eza -lah --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lsize='eza -lh --icons --sort=size --total-size'

# Robust alias for Zsh and macOS (handles multi-line entries)
alias cp_cmd='zmodload zsh/parameter 2>/dev/null; selected=$(for k in ${(nk)history}; do printf "%s\0" "$history[$k]"; done | fzf --read0 --tac --no-sort) && printf "%s" "$selected" | pbcopy && printf "\n%s\n\n✅ Copied!\n" "$selected"'

# Initialize completion system (MUST be done before any 'compdef' calls)
autoload -Uz compinit && compinit

# Enable completions for git aliases
compdef _git gcob=git
compdef _git gco=git
compdef _git gps=git
compdef _git gpl=git
compdef _git gc=git

export PATH="$HOME/.local/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
