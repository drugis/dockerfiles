FROM stackbrew/ubuntu:13.10

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# make sure the template DB is generated with UTF-8 encoding
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# install postgres
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1

# listen on all interfaces
RUN echo "listen_addresses = '*'" >>/etc/postgresql/9.1/main/postgresql.conf
RUN echo 'host all all 0.0.0.0/0 md5' >>/etc/postgresql/9.1/main/pg_hba.conf

ADD run-postgresql.sh /usr/local/bin/run-postgresql
RUN chown root.root /usr/local/bin/run-postgresql
RUN chmod +x /usr/local/bin/run-postgresql

VOLUME ["/var/lib/postgresql"]
EXPOSE 5432
CMD ["/usr/local/bin/run-postgresql"]
