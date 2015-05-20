Jenkins Docker serve
====================
Create a docker container with an initialised Jenkins that supports JUnit and Karma tests.

The jenkins home is mounted as a volume at `/var/jenkins_home`), and the jenkins user has UID 1000.

When upgrading the jenkins container, the home from the old volume can be reused as follows:

`docker run -d --volumes-from old-jenkins -p 8083:8080 --name jenkins jenkins-docker run`
