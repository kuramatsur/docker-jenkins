FROM ubuntu:12.04
#MAINTAINER Ben Firshman <ben@orchardup.com>
#-> K2

RUN apt-get update
RUN apt-get install -y curl
RUN curl http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update
# HACK: https://issues.jenkins-ci.org/browse/JENKINS-20407
RUN mkdir /var/run/jenkins
RUN apt-get install -y jenkins
ADD run /usr/local/bin/


#maven3
RUN apt-get -y install maven
ENV MAVEN_OPTS -XX:MaxPermSize=450m -Xms600m -Xmx2g

#timezone
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 8080
VOLUME ["/var/lib/jenkins", "/data"]
CMD ["/usr/local/bin/run"]
