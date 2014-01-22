#!/bin/bash

# make sure tomcat is killed when this process is
trap "kill -- -$BASHPID" EXIT

# remove old unpack
rm -rf /var/lib/tomcat7/webapps/ROOT

# the DB secrets have to be exposed as JAVA_OPTS for tomcat to find them
export JAVA_OPTS="-DMCDAWEB_DB_DRIVER=$MCDAWEB_DB_DRIVER -DMCDAWEB_DB_URL=$MCDAWEB_DB_URL -DMCDAWEB_DB_USERNAME=$MCDAWEB_DB_USERNAME -DMCDAWEB_DB_PASSWORD=$MCDAWEB_DB_PASSWORD"

# the tomcat configuration home
export CATALINA_BASE=/var/lib/tomcat7

# run tomcat without daemonizing
/usr/share/tomcat7/bin/catalina.sh run
