#!/bin/bash

su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres --single -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$1';"
su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf"
