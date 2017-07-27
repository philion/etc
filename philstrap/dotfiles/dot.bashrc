
export PATH=~/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:.:$PATH

# Don't wait for job termination notification
set -o notify

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

export FIGNORE='.DS_Store:.svn:.o:~'

# History Options

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit:ll:ls"

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

# CD Path: Making finding stuff easy.
export CDPATH=".:~/Projects:~"

## For AWS
complete -C aws_completer aws

### Docker ENV
if hash docker-machine 2>/dev/null; then
    echo Loading docker env
    eval "$(docker-machine env default)"
fi

# Aliases

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias more='less'
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias peek='mdfind -onlyin $PWD'
#alias tail='multitail -f'
alias ql='qlmanage -p "$@" >& /dev/null'
alias gti=git
alias flush-dns='sudo killall -HUP mDNSResponder'

alias dockup='eval $(dock up)'

function wess {
    curl -o - -i -s $* | less
}

function jurl {
    curl -s $* | prettyj
}

alias jack='ack --java --ignore-dir=target -k $*'

# Some shortcuts for different directory listings
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -hF -G'                 # classify files in colour
#alias dir='ls -G --format=vertical'
#alias vdir='ls -G --format=long'
alias ll='ls -g'                              # long list
alias la='ls -gA'                              # long list
alias l='ll -L'                              #

alias hist='history | grep -i $*'
alias psg='ps -ef | grep -i $*'

# Functions

# Some example functions
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

function prompt_command {

TERMWIDTH=${COLUMNS}

#   Calculate the width of the prompt:

hostnam=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
#   "whoami" and "pwd" include a trailing newline
usernam=$(whoami)
cur_tty=$(tty | sed -e "s/.*tty\(.*\)/\1/")
newPWD="${PWD}"
timestr=$(date "+%a %b %d %H:%M")
gitstr=""
#   Add all the accessories below ...
let promptsize=$(echo -n "  ${usernam}@${hostnam}:${newPWD}${timestr}${gitstr}" | wc -c | tr -d " ")
let fillsize=${TERMWIDTH}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill} "
	let fillsize=${fillsize}-1
done

if [ "$fillsize" -lt "0" ]
then
   let cut=3-${fillsize}
	newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
fi
}

PROMPT_COMMAND=prompt_command

function twtty {

local BAR_ON="\e[37;44m"
local BAR_OFF="\e[0m"

#case $TERM in
#    xterm*)
#        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
#        ;;
#    *)
#        TITLEBAR=""
#        ;;
#esac
TITLEBAR="\[\e]1;\]\h : \W\[\a\]"

PS1="$TITLEBAR\
$BAR_ON  \$usernam@\$hostnam:\${newPWD}\${gitstr}\${fill}\${timestr}$BAR_OFF\n> " 
}

# run the prompt!
twtty
