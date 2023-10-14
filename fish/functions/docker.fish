#!/usr/bin/env fish

function dexe -d "Ssh into a Docker container"
  set containerID (docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if test -z "$containerID"
    return
  end

  docker exec -it $containerID sh
end

function ddel -d "Stop a Docker container"
  set containerID (docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if test -z "$containerID"
    return
  end

  docker stop $containerID
end

function dlogs -d "Display logs of a Docker container"
  set containerID (docker ps --format '{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}' | __fzfp | awk '{print $1}')

  if test -z "$containerID"
    return
  end

  docker logs -f $containerID
end

function drmi -d "Remove a Docker image"
  set imageID (docker images --format '{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}' | __fzfp | awk '{print $1}')

  if test -z "$imageID"
    return
  end

  docker rmi $imageID
end
