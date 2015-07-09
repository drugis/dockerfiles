FROM phusion/baseimage

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update && apt-get clean
RUN apt-get update && apt-get install -y wget git curl zip

RUN apt-get install -y openjdk-7-jdk

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN apt-get install -y -q git
RUN apt-get install -y -q maven
RUN apt-get install -y -q firefox
RUN apt-get install -y -q chromium-browser
RUN apt-get install -y -q phantomjs
RUN apt-get install -y -q r-base-core
RUN apt-get install -y -q r-base-dev
RUN apt-get install -y -q r-cran-rjags
RUN apt-get install -y -q r-cran-xml
RUN apt-get install -y -q r-cran-plyr

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup | sudo bash - && \
    apt-get -y install python build-essential nodejs

# Global NPM installs
RUN npm install --silent -g grunt-cli bower karma karma-cli karma-qunit karma-junit-reporter karma-coverage istanbul protractor karma-chrome-launcher karma-phantomjs-launcher karma-jasmine karma-requirejs

# Jenkins home directoy is a volume, so configuration and build history
# can be persisted and survive image upgrades
# VOLUME /var/jenkins_home

RUN mkdir -p /var/jenkins_home
ENV JENKINS_HOME /var/jenkins_home

# RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref

ENV JENKINS_VERSION 1.596.2
ENV JENKINS_SHA 96ee85602a41d68c164fb54d4796be5d1d9cc5d0

# could use ADD but this one does not check Last-Modified header
# see https://github.com/docker/docker/issues/8331
RUN curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
#RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref
#RUN chown -R jenkins /usr/lib/node_modules
#RUN chown -R jenkins /root
# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

ENV COPY_REFERENCE_FILE_LOG /var/log/copy_reference_file.log
RUN touch $COPY_REFERENCE_FILE_LOG # && chown jenkins.jenkins $COPY_REFERENCE_FILE_LOG

# USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh

ENV MCDAWEB_DB_DRIVER org.h2.Driver
ENV MCDAWEB_DB_PASSWORD sa
ENV MCDAWEB_DB_URL jdbc:h2:../database
ENV MCDAWEB_OAUTH_GOOGLE_SECRET w0rp7-_Z_JQk_T0YcvMe3Aky
ENV MCDAWEB_OAUTH_GOOGLE_KEY 501575320185-sjffuboubldeaio8ngl1hrgfdj5a2nia.apps.googleusercontent.com
ENV MCDAWEB_DB_USERNAME sa

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
