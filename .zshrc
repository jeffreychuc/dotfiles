plugins=(
  git
  kubectl
)

source $ZSH/oh-my-zsh.sh

eval $(thefuck --alias)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function kv () {
  if [ ! -d "/usr/local/kubectl" ]; then
      sudo mkdir -p /usr/local/kubectl
      whoami=`whoami`
      sudo chown ${whoami}:admin /usr/local/kubectl
  fi

  if [ -e "/usr/local/kubectl/kubectl-$1" ]
  then
      ln -fs /usr/local/kubectl/kubectl-$1 /usr/local/bin/kubectl
  else
      curl -L https://storage.googleapis.com/kubernetes-release/release/v$1/bin/darwin/amd64/kubectl > /usr/local/kubectl/kubectl-$1
      chmod +x /usr/local/kubectl/kubectl-$1
      ln -fs /usr/local/kubectl/kubectl-$1 /usr/local/bin/kubectl
  fi

  echo "Version changed to $1."
}

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context)
}

alias kctx='kubectx'
