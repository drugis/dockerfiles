FROM stackbrew/ubuntu:13.10

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y exim4
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mailman

RUN mkdir -p /var/www/lists
RUN rm /etc/apache2/sites-enabled/*
ADD apache2/lists.drugis.org /etc/apache2/sites-enabled/lists.drugis.org.conf
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/cgi.load

ADD apache2-fg.sh /usr/local/bin/apache2-fg
RUN chmod +x /usr/local/bin/apache2-fg

ADD mailman/mm_cfg.py /etc/mailman/mailman_cfg.py

# If you have an existing mailman configuration, create a TAR of the data using
# cd /var/lib/mailman && sudo tar -cpvW -f mailman.data.tar ./data ./archives ./lists && sudo gzip mailman.data.tar
# If not, comment out the below lines:
RUN mkdir -p /srv/mailman
RUN rm -rf /var/lib/mailman/data /var/lib/mailman/archives /var/lib/mailman/lists
RUN ln -s /srv/mailman/data /var/lib/mailman/data
RUN ln -s /srv/mailman/archives /var/lib/mailman/archives
RUN ln -s /srv/mailman/lists /var/lib/mailman/lists

RUN echo "drugis.org" > /etc/mailname
ADD exim4 /etc/exim4

ADD aliases /etc/aliases

ADD start-all.sh /usr/local/bin/start-all
RUN chmod +x /usr/local/bin/start-all

EXPOSE 80 25

VOLUME ["/srv/mailman/"]
ENTRYPOINT ["/usr/local/bin/start-all"]
