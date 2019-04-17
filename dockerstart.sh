#!/bin/bash

PWD=$(cd `dirname $0`;pwd);

if ! docker images | grep -i dubbo-server; then
       docker build -t dubbo-server:v1.0 -f ${PWD}/jd8serverdockerfiles/Dockerfile ${PWD}/jdk
fi

if ! docker images | grep -i dubbo-client; then
    docker build -t dubbo-client:v1.0 -f ${PWD}/webdockerfiles/Dockerfile ${PWD}/jdk/
fi

file_server_paths=$(find ${PWD}/ -type d -name 'dubbo-server-*');
for file in ${file_server_paths[@]}
do
case "$1" in    
  run)  
${file}/drun.sh run
   ;;
  start)
 ${file}/drun.sh start
   ;;  
 stop)
 ${file}/drun.sh stop
   ;; 
 restart)
 ${file}/drun.sh restart
   ;; 
  rm)
 ${file}/drun.sh rm
   ;; 
  *)
    echo "Usage: dockerrun.sh {run|start|stop|restart|rm}"  
    exit $?
   ;;
esac
done
file_web_paths=$(find ${PWD}/ -type d -name 'webserver*');
for file in ${file_web_paths[@]}
do
case "$1" in    
  run)  
${file}/drun.sh run
   ;;
  start)
 ${file}/drun.sh start
   ;;  
 stop)
 ${file}/drun.sh stop
   ;; 
 restart)
 ${file}/drun.sh restart
   ;; 
  rm)
 ${file}/drun.sh rm
   ;; 
  *)
    exit 0
   ;;
esac
done 
