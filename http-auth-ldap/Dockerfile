FROM stackbrew/ubuntu:13.10

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lighttpd

## lighttpd config
ADD lighttpd/05-auth-ldap.conf /etc/lighttpd/conf-enabled/05-auth-ldap.conf
ADD ldap-ca.pem /etc/lighttpd/ldap-ca.pem
RUN echo "#!/bin/bash\n/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -D" >/usr/local/bin/run-httpd
RUN chmod +x /usr/local/bin/run-httpd
RUN ln -s /etc/lighttpd/conf-available/10-accesslog.conf /etc/lighttpd/conf-enabled/

EXPOSE 80

VOLUME ["/var/www"]
CMD ["/usr/local/bin/run-httpd"]
