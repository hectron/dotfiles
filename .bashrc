# HR: custom
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# show git branch when in a git repo
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}


export PS1='\[\033[0;32m\]λ\[\033[0;36m\] \w\[\033[0;33m\]$(parse_git_branch)\[\033[00m\]: '

# avoid using sudo npm
export PATH=$HOME/npm/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
