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

function kdes() {
  if [ -z $1 ]; then
    echo "Please provide resource"
    return
  fi

  resource=$(kubectl get $1 --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$resource" ]; then
    kubectl describe $1 ${resource}
  fi
}

function kdel() {
  if [ -z $1 ]; then
    echo "Please provide resource"
    return
  fi

  resource=$(kubectl get $1 --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$resource" ]; then
    kubectl delete $1 $resource
  fi
}

function klf() {
  if [ -z $1 ]; then
    echo "Please provide resource"
    return
  fi

  resource=$(kubectl get $1 --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$resource" ]; then
    container=$(__pick_container $resource)

    if [ -n "$container" ]; then
      kubectl logs -f ${1}/${resource} -c $container
    fi
  fi
}


function kpf() {
  if [ -z $1 ]; then
    echo "Please provide port"
    return
  fi

  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$pod" ]; then
    kubectl port-forward ${pod} $1
  fi
}

function ksf() {
  if [ -z $1 ]; then
    echo "Please provide port"
    return
  fi

  svc=$(kubectl get svc --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -n "$svc" ]; then
    kubectl port-forward svc/${svc} $1
  fi
}

function kexe() {
  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if [ -z "$pod" ]; then
    return
  fi

  container=$(__pick_container $pod)

  if [ -z "$container" ]; then
    return
  fi

  kubectl exec -it $pod -c $container -- ${1:-"sh"}
}
