#!/bin/bash

# remove old unpack
rm -rf /var/lib/tomcat7/webapps/ROOT

# the tomcat configuration home
export CATALINA_BASE=/var/lib/tomcat7

# run tomcat without daemonizing
/usr/share/tomcat7/bin/catalina.sh run
