#!/bin/bash

PWD=$(cd `dirname $0`;pwd);
PPATH=$(dirname ${PWD})

NAME='java-web'
VPATH="-v ${PWD}:/usr/local/java/jars"
LOCALPORT=8080
DOCKERPORT=8080

if [ $# -gt 1 ];then
    LOCALPORT=$2
fi


case $1 in
  run)
    if ! docker images | grep -i dubbo-client; then
    docker build -t dubbo-client:v1.0 -f ${PPATH}/webdockerfiles/Dockerfile ${PPATH}/jdk/
    fi
    echo docker run $NAME
    docker run --name $NAME -p $LOCALPORT:$DOCKERPORT $VPATH -d dubbo-client:v1.0
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
  
  status)
    docker ps -a|grep java-web
    exit 0
  ;;
  rmi)
   docker rmi dubbo-client:v1.0
   exit $?
  ;;
  *)
    exit 1
    ;;
esac
