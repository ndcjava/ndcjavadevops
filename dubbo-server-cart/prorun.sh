#!/bin/bash

PWD=$(cd `dirname $0`;pwd);
parentPath=$(dirname ${PWD})
cd ${PWD}
JAVA_HOME="${parentPath}/jdk/jdk1.8.0_152"
CLASSPATH="$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
JAVA_OPTS="-Xms1024m -Xmx1024m -Xmn512m -Xss256K -XX:SurvivorRatio=8 -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -XX:+UseConcMarkSweepGC -XX:ConcGCThreads=4 -XX:+CMSClassUnloadingEnabled -Dfile.encoding=UTF-8 -XX:+DisableExplicitGC -XX:+PrintGC -XX:+PrintGCTimeStamps -Xloggc:./gc.log"


case "$1" in    
  start)  
   nohup $JAVA_HOME/bin/java $JAVA_OPTS -jar ${PWD}/dubbo-server.jar> $PWD/server.log 2>&1 &  
   echo $! > ${PWD}/server.pid
   pid=$(cat ${PWD}/server.pid)
   echo "PID IS $pid SUCCESS START!!!"
   exit 0  
    ;;    
  stop)  
    pid=$(cat ${PWD}/server.pid)
    kill $pid  
    rm -rf $PWD/server.pid
    echo "PID IS $pid SUCCESS STOP"
    exit 0  
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
