## git
alias g='git'
alias gl='git pull origin $(git-branch-current)'
alias gd='git diff'
alias ga='git add'
alias gf='git commmit -m "f"'
alias gcm='git commit -m'
alias gp='git push origin $(git-branch-current)'
alias gss='git status -s'
alias gco='git checkout'
alias gb='git checkout -b'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gsh='git stash'
alias gshp='git stash pop'

## fasd
alias j='fasd_cd -d -i'    # cd, same functionality as j in autojump
eval "$(fasd --init auto)"

## nvim
alias nvim='NVIM_LISTEN_ADDRESS=127.0.0.1:32500 nvim'
alias vim='/usr/local/bin/nvim'
alias v='NVIM_LISTEN_ADDRESS=127.0.0.1:32500 fasd -f -t -e "nvr --remote-silent"'
alias V='vim'

## xp_runner
alias xp='xp_runner'
alias xpnl='xp_runner node logs'

## python
alias ptp=ptpython

## cd
alias cdg='cd `git rev-parse --show-toplevel`'
alias cdr='cd $HOME/Pandascore/tools/ramen/'
alias cdp='cd $HOME/Pandascore/pandavision/pndvsn'
alias cdx='cd $HOME/Pandascore/models/xp_runner/'
alias cd.='cd ..'

## ls
alias la='ls -a'
alias ll='ls -l'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

## qutebrowser
alias qb=qutebrowser

## rsync
alias rsync='rsync -a --info=progress2'

## diff
alias diff=icdiff

## quicklook
alias ql='builtin autoload -XUz'

## du sh
alias duh='du -sh *'
