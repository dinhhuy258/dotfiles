alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'

__pick_container() {
  containers=$(kubectl get pod $1 -o jsonpath='{.spec.containers[*].name}')
  if [ $(echo $containers | wc -w) -gt 1 ]; then
    container=$(echo $containers | tr " " "\n" | __fzfp --border="sharp")
  else
    container=$containers
  fi
  echo $container
}

kdel() {
  resource=$(kubectl get $1 --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$resource" ]; then
    kubectl delete $1 $resource
  fi
}

function klf() {
  resource=$(kubectl get $1 --no-headers -o custom-columns=":metadata.name" | __fzfp)
  if [ -n "$resource" ]; then
    container=$(__pick_container $resource)
    kubectl logs -f ${resource} -c $container
  fi
}


function kpf() {
  if [ -z $1 ]; then
    echo "Please provide port"
    return
  fi

  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  kubectl port-forward ${pod} $1
}

function ksf() {
  if [ -z $1 ]; then
    echo "Please provide port"
    return
  fi

  svc=$(kubectl get svc --no-headers -o custom-columns=":metadata.name" | __fzfp)

  kubectl port-forward svc/${svc} $1
}

function kexe() {
  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  container=$(__pick_container $pod)

  kubectl exec -it $pod -c $container -- ${1:-"sh"}
}
