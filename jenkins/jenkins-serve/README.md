Jenkins Docker serve
====================
Create a docker container with an initialised Jenkins that supports JUnit and Karma tests.

The jenkins home is mounted as a volume from `jenkins-home`), and the jenkins user should have UID 1000.

Example run command (8e0feabad3fc is the jenkins-home container id):

`docker run -d -volumes-from 8e0feabad3fc -p 8083:8080 jenkins-docker run`
