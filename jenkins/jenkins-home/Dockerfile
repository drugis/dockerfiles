FROM stackbrew/ubuntu:13.10

RUN useradd -m jenkins

ADD jenkins_home /home/jenkins/.jenkins

RUN chown -R jenkins:jenkins /home/jenkins/

VOLUME ["/home/jenkins/"]
