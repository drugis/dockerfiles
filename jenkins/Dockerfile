FROM phusion/baseimage

RUN echo http://cran.rstudio.com/bin/linux/ubuntu trusty/ >> /etc/apt/sources.list
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get clean && apt-get upgrade -y
RUN apt-get update && apt-get install -y wget git curl zip

RUN apt-get install -y openjdk-8-jdk

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64cdcdcd

RUN apt-get install -y -q git
RUN apt-get install -y -q maven
RUN apt-get install -y -q firefox
RUN apt-get install -y -q chromium-browser
RUN apt-get install -y -q libcurl-devel

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup | sudo bash - && \
    apt-get -y install python build-essential nodejs

# Global NPM installs
RUN npm install -g grunt-cli bower karma karma-cli karma-qunit karma-junit-reporter karma-coverage istanbul protractor karma-chrome-launcher karma-phantomjs-launcher karma-jasmine karma-requirejs

RUN mkdir -p /var/jenkins_home
ENV JENKINS_HOME /var/jenkins_home

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

COPY jenkins.sh /usr/local/bin/jenkins.sh

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh

# R for R tests
RUN apt-get install -y -q libcurl4-openssl-dev # needed for devtools package
RUN apt-get install -y -q libxml2-dev # needed for devtools package
RUN apt-get install -y -q libssl-dev # needed for devtools package
RUN apt-get install -y -q r-base-core
RUN apt-get install -y -q r-base
RUN apt-get install -y -q r-base-dev
RUN apt-get install -y -q r-cran-rjags
RUN apt-get install -y -q r-cran-xml
RUN apt-get install -y -q r-cran-plyr
RUN apt-get install -y -q r-cran-ggplot2

COPY gemtc_0.7.tar.gz gemtc_0.7.tar.gz
COPY testthat.tar.gz testthat.tar.gz

RUN R -e 'install.packages("testthat.tar.gz", repos=NULL, type="source"); if (!require("testthat")) quit(save="no", status=8)'
RUN R -e 'install.packages("igraph", repos="http://cran.rstudio.com/"); if (!require("igraph")) quit(save="no", status=8)'
RUN R -e 'install.packages("devtools", repos="http://cran.rstudio.com/"); if (!require("igraph")) quit(save="no", status=8)'
RUN R -e 'install.packages("meta", repos="http://cran.rstudio.com/"); if (!require("meta")) quit(save="no", status=8)'
RUN R -e 'install.packages("gemtc_0.7.tar.gz", repos=NULL, type="source"); if (!require("gemtc")) quit(save="no", status=8)'


ENV MCDAWEB_DB_DRIVER org.h2.Driver
ENV MCDAWEB_DB_PASSWORD sa
ENV MCDAWEB_DB_URL jdbc:h2:../database
ENV MCDAWEB_OAUTH_GOOGLE_SECRET w0rp7-_Z_JQk_T0YcvMe3Aky
ENV MCDAWEB_OAUTH_GOOGLE_KEY 501575320185-sjffuboubldeaio8ngl1hrgfdj5a2nia.apps.googleusercontent.com
ENV MCDAWEB_DB_USERNAME sa

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
