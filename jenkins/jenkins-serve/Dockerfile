FROM stackbrew/ubuntu:13.10

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get clean
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q fakeroot
RUN DEBIAN_FRONTEND=noninteractive fakeroot apt-get install -y -q openjdk-7-jdk
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q maven 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q firefox
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q chromium-browser
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q phantomjs

RUN wget -q -O- "https://chrislea.com/gpgkey.txt" | apt-key add -
RUN echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu saucy main" > /etc/apt/sources.list.d/chris-lea-node_js-saucy.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get clean

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q nodejs
RUN npm install -g karma
RUN npm install -g karma-qunit --save-dev
RUN npm install -g karma-junit-reporter --save-dev
RUN npm install -g karma-coverage --save-dev
RUN npm install -g bower --save-dev
RUN npm install -g istanbul --save-dev
RUN npm install -g protractor --save-dev

ADD https://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar /opt/selenium-server-standalone-2.39.0.jar
ADD http://mirrors.jenkins-ci.org/war/1.548/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ADD run /usr/local/bin/run
RUN useradd jenkins
RUN chown jenkins /opt/selenium-server-standalone-2.39.0.jar

ENV MCDAWEB_DB_DRIVER org.h2.Driver
ENV MCDAWEB_DB_PASSWORD sa
ENV MCDAWEB_DB_URL jdbc:h2:../database
ENV MCDAWEB_OAUTH_GOOGLE_SECRET w0rp7-_Z_JQk_T0YcvMe3Aky
ENV MCDAWEB_OAUTH_GOOGLE_KEY 501575320185-sjffuboubldeaio8ngl1hrgfdj5a2nia.apps.googleusercontent.com
ENV MCDAWEB_DB_USERNAME sa

EXPOSE 8080
