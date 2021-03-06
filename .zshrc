# Set up the prompt

autoload -Uz promptinit
promptinit
prompt walters

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
EDITOR=vim

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [ -f ~/.zprompt ]; then
	source ~/.zprompt
fi

precmd

## Include antigen 
if [ -f ~/antigen.zsh ]; then
    source ~/antigen.zsh
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle vagrant
    antigen apply
else
    curl -L git.io/antigen > antigen.zsh
    source antigen.zsh
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle vagrant
    antigen apply
fi

## Include Aliasses if files exists
if [ -f ~/.zaliasses ]; then
	source ~/.zaliasses
fi

## Include Functions if file exists
if [ -f ~/.zfunctions ]; then
	source ~/.zfunctions
fi

## deploy vim config if .vimrc does not exist
# configs from: https://github.com/amix/vimrc
if [ ! -f ~/.vimrc ]; then
    if [ -f ~/.vim_runtime/install_awesome_vimrc.sh ]; then
        sh ~/.vim_runtime/install_awesome_vimrc.sh
    fi
fi

