function fklfp() {
  pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)
  if [ -n "$pod" ]; then
    kubectl logs -f pods/${pod}
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

