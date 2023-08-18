PROMPT="%F{magenta}%n%f %F{cyan}%D %T %~%f
"
alias rm="rm -i"
alias la="ls -a"


autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}!"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

PROMPT=$PROMPT'${vcs_info_msg_0_}'" $ "

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"