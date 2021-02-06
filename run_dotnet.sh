#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "The run-dotnet.sh script takes a command as a argument. E.g., try ./run-dotnet.sh 'ls' "
    exit 1
fi

set -o noglob
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

COMMAND=$@



container_name=${CONTAINER_NAME:-"dotnet-for-$USER"}

command -v docker >/dev/null 2>&1 || { echo >&2 "Please install docker. E.g., go to https://www.docker.com/products/docker-desktop Type 'docker' to diagnose the problem."; exit 1; }

docker info >/dev/null 2>&1 || { echo >&2 "Docker server is not running? type 'docker info'."; exit 1; }

SSHPARAM=""
[ -e "${SSH_AUTH_SOCK}" ] && SSHPARAM="--volume /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock  --env SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock"
[ -e "${HOME}/.ssh" ] && SSHPARAM="--volume ${HOME}/.ssh:/home/$USER/.ssh:ro"  


docker image inspect $container_name >/dev/null 2>&1 || ( echo "instantiating the container" ; docker build --no-cache -t $container_name -f $SCRIPTPATH/Dockerfile --build-arg USER_NAME="$USER"  --build-arg USER_ID=$(id -u)  --build-arg GROUP_ID=$(id -g) .  )

# We run in privileged mode to have access to performance counters.
if [ -t 0 ]; then DOCKER_ARGS=-it; fi
docker run --rm $DOCKER_ARGS -h $container_name --privileged $SSHPARAM -v $(pwd):$(pwd):Z  -w $(pwd)  $container_name sh -c "$COMMAND"
