ANTIDOTE_HOME="${HOME}/.antidote"

source "${ANTIDOTE_HOME}/antidote.zsh"

antidote load
#autoload -Uz promptinit && promptinit && prompt starship
# call compinit onlz once per day for better performance
autoload -Uz compinit
if [ $(date +'%j') != $(stat -c '%z'  ~/.zcompdump | date +'%j') ]; then
  compinit
else
  compinit -C
fi

eval "$(starship init zsh)"


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Autocomplete colors
#if [[ -z "$LS_COLORS" ]]; then 
#	(( $+commands[dircolors] )) && eval "$(dircolors -b)" 
#fi
#https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
LS_COLORS=$LS_COLORS:'di=1;36:' ; export LS_COLORS

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# check if fzf version is equal or higher then 0.48.0
fzf_version=$(fzf --version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
IFS='.' read -r major minor patch <<< "$fzf_version"
if [[ $major -ge 0 && $minor -ge 48 && $patch -ge 0 ]]; then
  eval "$(fzf --zsh)"
else
  source "/usr/share/doc/fzf/examples/completion.zsh"
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  zstyle ':fzf-tab:*' fzf-bindings-default 'tab:down,btab:up,change:top,ctrl-space:toggle,bspace:backward-delete-char,ctrl-h:backward-delete-char'
fi


alias ls='ls --color'
alias la='ls --color -la'
alias c='clear'

unalias z