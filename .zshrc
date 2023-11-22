# Set up asdf
. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt clint

# Set up the $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set up aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Set up history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Set up auto-completion
autoload -Uz compinit
compinit

# Set up command correction
setopt CORRECT

# Set up the key bindings
bindkey -e

# Set up the color scheme
autoload -Uz colors && colors

# Set up the directory navigation
setopt AUTO_CD

# Set up the globbing
setopt EXTENDED_GLOB
