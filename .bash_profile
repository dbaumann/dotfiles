function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' | sed -e 's/*//'
}

function count_git_changes {
  status=`git status -s 2> /dev/null`
  if [ -n "$status" ] && [ `echo $status | wc -l` -gt 0 ]; then
    echo " `echo "$status" | wc -l | tr -d ' '`"
  fi
}

# PROMPT
PS1='[\[\033[01;36m\]\W\[\033[00m\]\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\[\033[32m\]$(count_git_changes)\[\033[00m\] \D{%T}]\$ '
# if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
#   GIT_PROMPT_THEME=Default
#   source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
# fi

# LOCAL SERVICE CONFIG
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
export MONGOC_VERBOSE=1 # for mongohub debugging; run /Applications/MongoHub.app/Contents/MacOS/MongoHub and observe output
export CDPATH=.:$HOME/TWC/fu
# /usr/local/opt/memcached/bin/memcached # freze?

# ALIASES
source ~/bin/aliases
# source ~/TWC/fu/dev-environment/ipvs_functions.sh

# SYSTEM PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# TWC PATH
PATH=$PATH:~/bin:$HOME/TWC/fu/openstack-client/bin
PATH=$PATH:~/bin:$HOME/TWC/fu/dev-environment/bin
PATH=$PATH:~/bin:$HOME/TWC/fu/dev-environment/bin/mongo

# COMPLETION
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# MISC
# # because mac os won't do this otherwise
# source ~/.bashrc

# http://www.elliottsprehn.com/blog/2010/09/18/delete-key-issues-with-h-ctrl-h-and-ssh-on-os-x/
#stty erase ^H
