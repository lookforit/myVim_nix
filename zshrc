# Created by newuser for 5.1.1
source "$HOME/.antigen/antigen.zsh"


# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).

antigen bundle extract
antigen bundle fedora
antigen bundle fasd
antigen bundle git
antigen bundle git-extras
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle sudo
antigen bundle nvm
antigen bundle npm
antigen bundle node
antigen bundle zsh-users/zsh-completions
antigen bundle thewtex/tmux-mem-cpu-load
antigen bundle tmux
antigen bundle tmuxinator

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_NVM_SHOW=true
#BULLETTRAIN_NVM_BG=magenta

# Tell antigen that you're done.
antigen apply

# zsh-completions options:
compdef _gnu_generic foobar goocar hoodar

# use most pager
export PAGER="/usr/bin/most -s"


# Enable 256 color
alias tmux="tmux -2"

# Tmuxinator completion
source ~/.bin/tmuxinator.zsh

# Editor choose
export EDITOR='vim'

#### The following is to enable zsh-autosuggestions plugin

# Load zsh-syntax-highlighting.
source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting.git/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
