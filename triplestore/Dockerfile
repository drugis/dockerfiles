FROM ubuntu:14.04

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q fakeroot
RUN DEBIAN_FRONTEND=noninteractive fakeroot apt-get install -y -q openjdk-7-jdk

ADD https://archive.apache.org/dist/jena/binaries/apache-jena-2.12.1.tar.gz /tmp/jena.tar.gz 
RUN tar -xzf /tmp/jena.tar.gz -C /usr/share

ADD https://archive.apache.org/dist/jena/binaries/jena-fuseki-1.1.1-distribution.tar.gz  /tmp/fuseki.tar.gz
RUN tar -xzf /tmp/fuseki.tar.gz -C /usr/share

ENV JENA_HOME /usr/share/apache-jena-2.12.1
ENV FUSEKI_HOME /usr/share/jena-fuseki-1.1.1
ENV PATH $FUSEKI_HOME:$JENA_HOME/bin:$PATH

EXPOSE 3030
CMD ["fuseki-server", "--update", "--mem", "/ds"]

