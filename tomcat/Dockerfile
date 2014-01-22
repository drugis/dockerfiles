FROM stackbrew/ubuntu:13.10

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q tomcat7
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q supervisor

RUN curl "http://jdbc.postgresql.org/download/postgresql-9.3-1100.jdbc4.jar" -o /usr/share/tomcat7/lib/postgresql-9.3-1100.jdbc4.jar

## supervisor configuration
ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/run/supervisor

## tomcat configuration
ADD tomcat7-run.sh /usr/local/bin/tomcat7-run
RUN chown root.root /usr/local/bin/tomcat7-run
RUN chmod +x /usr/local/bin/tomcat7-run
ADD server.xml /etc/tomcat7/
RUN chown root.root /etc/tomcat7/server.xml

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
