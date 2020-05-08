## general variables
export HOMEBREW_NO_AUTO_UPDATE=1
# export PATH="/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"
export EDITOR='/usr/local/bin/nvim'
export VISUAL='NVIM_LISTEN_ADDRESS=127.0.0.1:32500 nvr --remote-tab-silent'
export GPG_TTY=$(tty)

# WSL nvim setup
if [[ -n $WSLENV ]]; then
  export NEOVIM_WIN_DIR='/mnt/c/tools/neovim/Neovim'
  export PATH="$NEOVIM_WIN_DIR/bin:$PATH"
fi

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
if [[ -e $PYENV_ROOT ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  if [[ -n $MAIN_VENV && $(pyenv version | sed 's/\s.*//') != $MAIN_VENV ]]; then
    pyenv activate $MAIN_VENV
  fi
fi

eval $(thefuck --alias)

## zsh variables
export ZSH_THEME=""
export ZGEN_AUTOLOAD_COMPINIT=0
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.zhistory

## OPTIONS
# append into history file
setopt INC_APPEND_HISTORY_TIME
# save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
# dont save if cmd start with a space
setopt HIST_IGNORE_SPACE
# remove duplicates first when trimming
setopt HIST_EXPIRE_DUPS_FIRST
# add timestamp for each entry
setopt EXTENDED_HISTORY  

## fzf variables
export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPTS='--bind tab:down --cycle'
export FZF_DEFAULT_COMMAND='ag -l --ignore .git --nocolor --hidden -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export __fzf_fasd_default_completion=$fzf_default_completion

## zsh binds
# forward through suggestion with <C-N>
bindkey "^B" backward-kill-word
bindkey "^N" forward-word
# fzf completion with <C-V>
bindkey '^V' fzf-completion
# basic completion with <C-I> / <Tab>
bindkey '^I' __fzf_fasd_zsh_completion

## weird stuff
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_ALL=

## git functions
function git-branch-current {
  if ! command git rev-parse 2> /dev/null; then
    print "$0: not a repository: $PWD" >&2
    return 1
  fi
  local ref="$(command git symbolic-ref HEAD 2> /dev/null)"
  if [[ -n "$ref" ]]; then
    print "${ref#refs/heads/}"
    return 0
  else
    return 1
  fi
}

# autocompletions
autoload -U bashcompinit
bashcompinit
eval $(register-python-argcomplete pipx)

cd $HOME
