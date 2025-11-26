# starship
eval "$(starship init zsh)"

# aliases
alias rm="rm -i"
alias la="ls -a"
alias gcob='git checkout -b'
alias gco='git checkout'
alias gps='git push'
alias gpl='git pull'
alias gc='git commit -m'
# Robust alias for Zsh and macOS (using pbcopy)
alias cp_cmd="history | fzf | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' | tee /dev/tty | pbcopy && echo -e '\n✅ Copied!'"

# Enable completions for git aliases
compdef _git gcob=git
compdef _git gco=git
compdef _git gps=git
compdef _git gpl=git
compdef _git gc=git

export PATH="$HOME/.local/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
autoload -Uz compinit && compinit
