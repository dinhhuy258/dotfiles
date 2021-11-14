function dexe() {
  containerID=$(docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if [ -z "$containerID" ]; then
    return
  fi

  docker exec -t $containerID sh 
}

function dstop() {
  containerID=$(docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if [ -z "$containerID" ]; then
    return
  fi

  docker stop $containerID 
}

function dlogs() {
  containerID=$(docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if [ -z "$containerID" ]; then
    return
  fi

  docker logs -f $containerID 
}

function drmi() {
  imageID=$(docker images --format '{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}'| __fzfp | awk '{print $1}')
  if [ -z "$imageID" ]; then
    return
  fi

  docker rmi $imageID
}
