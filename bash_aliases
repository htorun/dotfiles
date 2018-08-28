# Aliases to change the current shell prompt.
# p1 is my multi-line prompt
alias p0=prompt_off
alias p1=prompt_on

# My aliases
alias rmdir='rm -r'
alias md='mkdir'

alias ls='ls --color=auto'
alias l='ls --group-directories-first'
alias la='ls -a --group-directories-first'
alias lA='ls -Al --group-directories-first'
alias ll='ls -l --group-directories-first'
alias lal='ls -la --group-directories-first'
alias ltr='ls -ltr'
alias lltr='ls -altr'
alias lc1='l -c1'

alias mls='ls | less'
alias ml='ls | less'
alias mla='la | less'
alias mlal='lal | less'
alias mll='ll | less'

alias clr='clear'
alias cla='clear;la'
alias cll='clear;ll'
alias clt='clear;ltr'
alias cls='clear;ls'
alias clal='clear;lal'
alias clatr='clear;latr'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias b='cd -'

alias ff='find . -type f -name $1'
alias ff1='find . -maxdepth 1 -type f -name $1'
alias h='history'
alias d='date'

alias more='less'
alias m='more'

alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agp='sudo apt-get purge'
alias agu='sudo apt-get update'
alias aga='sudo apt-get autoremove'
alias acs='apt-cache search'
alias acp='apt-cache policy'

alias api='sudo apt install'
alias apr='sudo apt remove'
alias app='sudo apt purge'
alias apu='sudo apt update'
alias apa='sudo apt autoremove'

alias dql='dpkg-query -l'
alias dqL='dpkg-query -L'
alias dqS='dpkg-query -S'

alias nmr='sudo service network-manager restart'

#alias gs='git status '
#alias ga='git add '
#alias gb='git branch '
#alias gc='git commit'
#alias gd='git diff'
#alias go='git checkout ' # this one conflicts with go language
#alias gk='gitk --all&'
#alias gx='gitx --all'

alias tvim='gnome-terminal --tab-with-profile=Vim -x vim'
