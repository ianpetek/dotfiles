ANTIDOTE_HOME="${HOME}/.antidote"

if [ ! -d "$ANTIDOTE_HOME" ]; then
	mkdir -p "$ANTIDOTE_HOME"
	git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME" 
fi

source "${ANTIDOTE_HOME}/antidote.zsh"

antidote load
#autoload -Uz promptinit && promptinit && prompt starship
autoload -U compinit && compinit

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

alias ls='ls --color'
alias la='ls --color -la'
alias c='clear'

unalias z

eval "$(fzf --zsh)"


