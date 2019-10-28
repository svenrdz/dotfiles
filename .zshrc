ZSH_DEBUG=false
if [[ $ZSH_DEBUG == true ]]; then
  zmodload zsh/zprof
fi
bindkey -v
source "${HOME}/.zgen/zgen.zsh"
source $HOME/.pyenv/versions/panda36/bin/activate
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

for rcfile in ~/.zsh/*.zsh; do
  source $rcfile
done

# if the init script doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  zgen prezto

  # default
  zgen prezto history
  zgen prezto completion

  # extra
  zgen prezto docker
  zgen load junegunn/fzf shell
  zgen load svenrdz/fzf-fasd
  zgen load dfurnes/purer
  zgen load laurenkt/zsh-vimto

  # last
  zgen prezto history-substring-search
  zgen load zdharma/fast-syntax-highlighting
  zgen prezto autosuggestions

  zgen save
fi

if [[ $ZSH_DEBUG == true ]]; then
  zprof
fi
