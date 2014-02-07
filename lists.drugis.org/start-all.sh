#!/bin/bash

# make sure mailman can access the data
chown -R root.list /srv/lists.drugis.org/data /srv/lists.drugis.org/lists /srv/lists.drugis.org/archives
check_perms -f

service exim4 start
service mailman start

/usr/local/bin/apache2-fg
