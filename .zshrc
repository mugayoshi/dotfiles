# starship
eval "$(starship init zsh)"

# history
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000

setopt inc_append_history

# aliases
alias rm="rm -i"
alias la="ls -a"
alias gcob='git checkout -b'
alias gco='git checkout'
alias gps='git push'
alias gpl='git pull'
alias gc='git commit -m'
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
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
