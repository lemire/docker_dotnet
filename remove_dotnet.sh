#!/usr/bin/env bash

container_name=${CONTAINER_NAME:-"dotnet-for-$USER"}
echo $container_name
echo " Removing the container "
docker ps -a | awk '{ print $1,$2 }' | grep $container_name| awk '{print $1 }' | xargs -I {} docker stop -t 1 {} | xargs docker rm 
# removing image
docker image rm $container_name
