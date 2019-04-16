#!/bin/bash

PWD=$(cd `dirname $0`;pwd);
PPATH=$(dirname ${PWD})
cd ${PWD}
JAVA_HOME="${PPATH}/jd8serverdockerfiles/jdk"
CLASSPATH="$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
CATALINA_HOME="${PWD}/tomcat8"
case "$1" in    
  start)  
   ${PWD}/tomcat8/bin/startup.sh
   exit $?
    ;;    
  stop)  
    ${PWD}/tomcat8/bin/shutdown.sh
    ;;   
  restart)  
    $0 stop  
    sleep 1  
    $0 start
    exit 0  
    ;;    
  *)  
    echo "Usage: run.sh {start|stop|restart}"  
    exit $?
    ;;    
esac
