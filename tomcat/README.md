Tomcat7 Dockerfile
==================

Runs a tomcat7 instance with a single root context behind a reverse proxy. To
build:

    docker build -t=tomcat .

For an example of a run script, see `mcdaweb-run.sh`.

Upload your WAR using `scp`, then `supervisorctl restart tomcat` to deploy it.

Configuration
-------------

Set the tomcatProxyName, tomcatProxyPort, and tomcatProxyScheme system
properties. See the example run script.
