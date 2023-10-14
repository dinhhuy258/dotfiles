#!/usr/bin/env fish

function __pick_container
  set containers (kubectl get pod $argv[1] -o jsonpath='{.spec.containers[*].name}')
  if test (echo $containers | wc -w) -gt 1
    set container (echo $containers | tr " " "\n" | __fzfp --border="sharp")
  else
    set container $containers
  end

  echo $container
end

function kdes -d "Describe kubernetes resource (default: pod). Usage: kdes, kdes service, ..."
  set resouce_name $argv[1]
  if test -z $argv[1]
    set resouce_name "pod"
  end

  set resource (kubectl get $resouce_name --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -n "$resource"
    kubectl describe $resouce_name $resource
  end
end

function kdel -d "Delete kubernetes resource (default: pod). Usage: kdel, kdel service, ..."
  set resouce_name $argv[1]
  if test -z $argv[1]
    set resouce_name "pod"
  end

  set resource (kubectl get $resouce_name --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -n "$resource"
    kubectl delete $resouce_name $resource
  end
end

function klf -d "Logs kubernetes resource (default: pod). Usage: klf, klf service, ..."
  set resouce_name $argv[1]
  if test -z $argv[1]
    set resouce_name "pod"
  end

  set resource (kubectl get $resouce_name --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -n "$resource"
    set container (__pick_container $resource)

    if test -n "$container"
      kubectl logs -f $resouce_name/$resource -c $container
    end
  end
end

function kpf -d "Port forward kubernetes pod. Usage: kpf 8080"
  if test -z $argv[1]
    echo "Please provide port"

    return
  end

  set pod (kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -n "$pod"
    kubectl port-forward $pod $argv[1]
  end
end

function ksf -d "Port forward kubernetes service. Usage: ksf 8080"
  if test -z $argv[1]
    echo "Please provide port"

    return
  end

  set svc (kubectl get svc --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -n "$svc"
    kubectl port-forward svc/$svc $argv[1]
  end
end

function kexe -d "Ssh into kubernetes pod. Usage: kexe"
  set pod (kubectl get pods --no-headers -o custom-columns=":metadata.name" | __fzfp)

  if test -z "$pod"
    return
  end

  set container (__pick_container $pod)

  if test -z "$container"
    return
  end

  kubectl exec -it $pod -c $container -- "bash"
end

function kctx -d "Switch or get current kubernetes context. Usage: kctx, kctx set"
  if test -n "$argv[1]" -a "$argv[1]" = "set"
    set ctx (kubectl config get-contexts --no-headers -o=name | __fzfp)
    if test -z "$ctx"
      return
    end

    kubectl config use-context $ctx
  else
    kubectl config current-context
  end
end
