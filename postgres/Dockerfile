FROM stackbrew/ubuntu:13.10

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1

RUN echo "listen_addresses = '*'" >>/etc/postgresql/9.1/main/postgresql.conf
RUN echo 'host all all 0.0.0.0/0 md5' >>/etc/postgresql/9.1/main/pg_hba.conf

ADD run-postgresql.sh /usr/local/bin/run-postgresql
RUN chown root.root /usr/local/bin/run-postgresql
RUN chmod +x /usr/local/bin/run-postgresql

VOLUME ["/var/lib/postgresql"]
EXPOSE 5432
CMD ["/usr/local/bin/run-postgresql"]
