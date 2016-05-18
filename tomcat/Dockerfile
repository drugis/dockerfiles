FROM phusion/baseimage

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q fakeroot
RUN DEBIAN_FRONTEND=noninteractive fakeroot apt-get install -y -q openjdk-8-jdk

RUN curl "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64.tar.gz" -o /tmp/tomcat7.tar.gz


RUN tar -xzf /tmp/tomcat7.tar.gz -C /tmp
RUN rm -rf /tmp/apache-tomcat-7.0.64/webapps/*
RUN mkdir -p /usr/share/tomcat7
RUN mv /tmp/apache-tomcat-7.0.64/* /usr/share/tomcat7

## tomcat configuration
RUN mkdir /etc/service/tomcat
ADD tomcat7-run.sh /etc/service/tomcat/run
ADD ROOT.war /usr/share/tomcat7/webapps/ROOT.war
RUN chmod +x /etc/service/tomcat/run
ADD server.xml /usr/share/tomcat7/conf/server.xml
RUN chown root.root /usr/share/tomcat7/conf/server.xml

# add keystore and truststore
RUN mkdir /ssl
ADD ssl/keystore.jks /ssl/keystore.jks
ADD ssl/truststore.jks /ssl/truststore.jks

EXPOSE 8080
CMD ["/sbin/my_init"]
