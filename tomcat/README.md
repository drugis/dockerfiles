Tomcat7 Dockerfile
==================

Runs a tomcat7 instance with a single root context behind a reverse proxy. To
build, place your WAR (named ROOT.war) in this directory, then run  :

    docker build -t=tomcat .

For an example of a run script, see `mcdaweb-run.sh`.

Configuration
-------------

Set the tomcatProxyName, tomcatProxyPort, and tomcatProxyScheme system
properties. See the example run script.
