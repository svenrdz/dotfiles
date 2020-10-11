# ZSH_DEBUG=true
if [[ -n $ZSH_DEBUG ]]; then
  zmodload zsh/zprof
fi

bindkey -v
source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions

  zgen load mafredri/zsh-async
  zgen load dfurnes/purer

  zgen load softmoth/zsh-vim-mode
  zgen load mollifier/anyframe

  zgen load junegunn/fzf shell
  zgen load svenrdz/fzf-fasd

  zgen load zsh-users/history-substring-search
  zgen load zdharma/fast-syntax-highlighting

  zgen save
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

rcfiles=( env.local.zsh config.zsh jira.zsh panda.zsh alias.zsh )
for rcfile in $rcfiles; do
  rcfile=$HOME/.zsh/$rcfile
  test -e $rcfile && source $rcfile
done

if [[ -n $ZSH_DEBUG ]]; then
  zprof
fi

# Created by `userpath` on 2020-05-08 16:42:50
export PATH="$PATH:/home/sven/.local/bin"

eval $(thefuck --alias)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sven/Pandascore/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sven/Pandascore/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sven/Pandascore/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sven/Pandascore/google-cloud-sdk/completion.zsh.inc'; fi
