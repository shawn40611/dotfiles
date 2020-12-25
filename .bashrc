# prompt
export PS1="\[\033[32m\][${debian_chroot:+($debian_chroot)}\[\033[33m\]\u@\h \[\033[1;34m\]\w\[\033[32m\]]\[\033[31m\]\$git_branch\[\033[1;34m\][\t]
\[\033[00;33m\]\$ "


export PATH=/usr/local/opt/curl/bin:$PATH
# VI
set -o vi
export EDITOR='vim'

# Environments
# export TERM=xterm-color
export LC_ALL=en_US.UTF-8

# bind the command history search
bind '"\x1b\x5b\x41":history-search-backward'
bind '"\x1b\x5b\x42":history-search-forward'

# grep recursively and case insensitively the current folder
gr(){
  grep -rni "$1" .
}

# for bash completion
if [ -f /opt/local/etc/bash_completion ]; then
   source /opt/local/etc/bash_completion
   echo
fi

# trace directory paths
alias cd="pushd >/dev/null 2>&1"
alias p="popd >/dev/null 2>&1"

# colorful ls
alias ls='ls -G -v -F'

# setup branch var after each command
PROMPT_COMMAND='find_git_branch'

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    export git_branch="[$branch]"
  else
    export git_branch=""
  fi
}

# Auto start ssh-agent
SSH_AGENT_PID=`pgrep -U $USER -o 'ssh-agent'`
if [ -z $SSH_AGENT_PID ]; then
    eval $(ssh-agent -s)
    ssh-add
else
    SSH_AGENT_SOCK=`find /tmp -user $USER -path '*ssh*' -type s -iname 'agent.'$(($SSH_AGENT_PID-1)) 2>/dev/null`
    export SSH_AGENT_PID="$SSH_AGENT_PID"
    export SSH_AUTH_SOCK="$SSH_AGENT_SOCK"
fi

