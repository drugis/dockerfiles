#!/bin/bash

# make sure mailman can access the data
chown -R root.list /srv/mailman/data /srv/mailman/lists /srv/mailman/private
check_perms -f

service exim4 start
service mailman start

/usr/local/bin/apache2-fg
