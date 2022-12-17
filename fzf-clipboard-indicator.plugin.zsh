
## Custom binding ALT-x - Select item from clipboard
fzf-item_clipboard-widget() {
  local items=("${(@f)$(jq '.[].contents' $HOME/.cache/clipboard-indicator@tudmotu.com/registry.txt)}")
  local list=""
  for i in "${items[@]}" 
  do 
    local str="${i:1}"
    str=$(sed 's/.\{1\}$//' <<< "$str")
    list+="$str"$'\n'
  done
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  echo $list | sort -u | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_CTRL_Y_OPTS-}" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}
zle     -N              fzf-item_clipboard-widget
bindkey -M emacs '\ex'  fzf-item_clipboard-widget
bindkey -M vicmd '\ex'  fzf-item_clipboard-widget
bindkey -M viins '\ex'  fzf-item_clipboard-widget

