Jenkins Docker serve
====================
Create a docker container with an initialised Jenkins that supports JUnit and Karma tests.

The jenkins home is mounted as a volume at `/var/jenkins_home`.

When upgrading the jenkins container, the home from the old volume can be reused as follows:

`docker run -d -p 8083:8080 --name jenkins -v /home/deploy/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -v /home/deploy/dockerfiles:/home/deploy/dockerfiles jenkins-docker`
