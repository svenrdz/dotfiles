ZSH_DEBUG=false
if [[ $ZSH_DEBUG == true ]]; then
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

for rcfile in ~/.zsh/*.zsh; do
  source $rcfile
done

if [[ $ZSH_DEBUG == true ]]; then
  zprof
fi

# Created by `userpath` on 2020-05-08 16:42:50
export PATH="$PATH:/home/sven/.local/bin"
