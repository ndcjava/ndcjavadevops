FROM centos
MAINTAINER chendi
RUN mkdir /usr/local/java
ADD jdk8.tar.gz /usr/local/java/
RUN ln -s /usr/local/java/jdk1.8.0_152 /usr/local/java/jdk
ENV JAVA_HOME /usr/local/java/jdk
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH ${JAVA_HOME}/bin:$PATH
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
EXPOSE 8080
ENTRYPOINT ["/usr/local/java/jars/tomcat8/bin/catalina.sh","run"]
