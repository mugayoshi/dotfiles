alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias la="ls -a"

PS1='$(basename "$(dirname "$(pwd)")")/$(basename "$(pwd)") \$:$(date +"%Y-%m-%d %H:%M:%S")
$(git_prompt_info)\$ '

git_prompt_info() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch_name="$(git symbolic-ref --short HEAD 2>/dev/null)"
    if [[ -n "$branch_name" ]]; then
      local status="$(git status --porcelain 2>/dev/null)"
      local ahead="$(git rev-list --count --left-only @{u}...HEAD 2>/dev/null)"
      local behind="$(git rev-list --count --right-only @{u}...HEAD 2>/dev/null)"
      local staged="$(grep -c '^M' <<< "$status")"
      local modified="$(grep -c '^ M' <<< "$status")"
      local deleted="$(grep -c '^ D' <<< "$status")"
      local untracked="$(grep -c '^??' <<< "$status")"
      echo " [${branch_name}$(git_prompt_ahead_behind "$ahead" "$behind") $(git_prompt_counts "$staged" "$modified" "$deleted" "$untracked")]"
    fi
  fi
}

git_prompt_ahead_behind() {
  local ahead=$1
  local behind=$2
  local result=""
  if [[ "$ahead" -gt 0 ]]; then
    result+=" ↑$ahead"
  fi
  if [[ "$behind" -gt 0 ]]; then
    result+=" ↓$behind"
  fi
  echo "$result"
}