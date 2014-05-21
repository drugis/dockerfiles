FROM stackbrew/ubuntu:13.10

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q fakeroot
RUN DEBIAN_FRONTEND=noninteractive fakeroot apt-get install -y -q openjdk-7-jdk

RUN curl "http://apache.hippo.nl/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz" -o /tmp/tomcat7.tar.gz

RUN tar -xzf /tmp/tomcat7.tar.gz -C /tmp
RUN mkdir -p /usr/share/tomcat7
RUN mv /tmp/apache-tomcat-7.0.53/* /usr/share/tomcat7

## memo: remove webapps

## supervisor configuration
ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/run/supervisor

## tomcat configuration
ADD tomcat7-run.sh /usr/local/bin/tomcat7-run
RUN chown root.root /usr/local/bin/tomcat7-run
RUN chmod +x /usr/local/bin/tomcat7-run
ADD server.xml /usr/share/tomcat7/conf/server.xml
RUN chown root.root /usr/share/tomcat7/conf/server.xml

## sshd config
# work-around for http://gaijin-nippon.blogspot.nl/2013/07/audit-on-lxc-host.html
RUN sed -i 's/^\(session    required     pam_loginuid.so\)$/#\1/' /etc/pam.d/sshd
# create required directory for sshd
RUN mkdir /var/run/sshd
# add authorized_keys
RUN mkdir /root/.ssh
ADD root_authorized_keys /root/.ssh/authorized_keys
RUN chown root.root /root/.ssh/authorized_keys
RUN chmod 0644 /root/.ssh/authorized_keys

EXPOSE 22 8080
CMD ["/usr/bin/supervisord"]
