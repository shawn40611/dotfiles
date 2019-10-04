# prompt
export PS1="\[\033[32m\][${debian_chroot:+($debian_chroot)}\[\033[33m\]\u@\h \[\033[1;34m\]\w\[\033[32m\]]\[\033[31m\]\$git_branch\$(set_spacing)\[\033[1;34m\][\t]
\[\033[00;33m\]\$ "
function set_spacing() {
  local debian_chroot= ${debian_chroot:+($debian_chroot)}
  local user=$USER
  local hostname=${HOSTNAME%%.*}
  local git_branch=$git_branch
  local dir=${PWD/$HOME}
  local time=`date +%H:%M:%S`
  local termwidth
  (( termwidth = ${COLUMNS} - ${#debian_chroot} - ${#user} - ${#hostname} - ${#git_branch}
  - ${#dir} - ${#time} - 7))
  local spacing=""
  for i in $(seq 1 $termwidth); do
      spacing="${spacing} "
  done

  echo "${spacing}"
}


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

