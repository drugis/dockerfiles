#!/bin/bash

# remove old unpack
rm -rf /usr/share/tomcat7/webapps/ROOT

# run tomcat without daemonizing
/usr/share/tomcat7/bin/catalina.sh run
