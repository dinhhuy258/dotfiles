function fklfp() {
  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)
  if [ -n "$pod" ]; then
    if [ -z $1 ]; then
      kubectl logs -f pods/${pod}
    else
      kubectl logs -f pods/${pod} -c $1
    fi
  fi
}

function fklfj() {
  job=$(kubectl get jobs --no-headers -o custom-columns=":metadata.name" | __fzfp)
  if [ -n "$job" ]; then
    kubectl logs -f jobs/${job}
  fi
}

function fkdj() {
  job=$(kubectl get jobs --no-headers -o custom-columns=":metadata.name" | __fzfp)
  if [ -n "$job" ]; then
    kubectl delete jobs/${job}
  fi
}

function fkpf() {
  if [ -z $1 ]; then
    echo "Please provide port"
    return
  fi

  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  kubectl port-forward ${pod} $1
}
