#!/bin/bash

PWD=$(cd `dirname $0`;pwd);
PPATH=$(dirname ${PWD})

NAME='cart'
VPATH="-v ${PWD}/serverconfig.properties:/serverconfig.properties  -v ${PWD}/dubbo-server.jar:/dubbo-server.jar"

case $1 in
  run)
    if ! docker images | grep -i dubbo-server; then
       docker build -t dubbo-server:v1.0 -f ${PPATH}/jd8serverdockerfiles/Dockerfile ${PPATH}/jdk
    fi
    echo docker run $NAME
    docker run --net=host --name $NAME $VPATH -d dubbo-server:v1.0
    exit $?
    ;;
  start)
    echo docker start $NAME
    docker start $NAME
    exit $?
    ;;
  stop)
    echo docker stop $NAME
    docker stop $NAME
    exit $?
    ;;
  restart)
  	echo docker stop $NAME
  	echo docker start $NAME
  	docker stop $NAME
  	docker start $NAME
  	exit $?
    ;;
  rm)
    echo docker stop $NAME
    echo docker rm $NAME
    docker stop $NAME
    docker rm $NAME
    exit $?
  ;;
  rmi)
    echo docker stop $NAME
    echo docker rm $NAME
    echo docker rmi $NAME
    docker stop $NAME
    docker rm $NAME
    docker rmi dubbo-server:v1.0      
    exit $?
  ;;
  status)
  docker ps -a|grep $NAME
  ;;
  *)
    exit 1
    ;;
esac
