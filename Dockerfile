FROM alpine

MAINTAINER Ayoub EL ABASSI <a.elabassi@cathedis.ma>

ENV TOMCAT_VERSION 8.0.53

# Install dependencies
RUN apk upgrade && \
apk update

# Install JDK 8
RUN apk add openjdk8

# Get Tomcat
# RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
RUN wget --quiet https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.tar.gz -O /tmp/tomcat.tar.gz && \
tar xzvf /tmp/tomcat.tar.gz -C /opt && \
mv /opt/apache-tomcat-8.5.50 /opt/tomcat && \
rm /tmp/tomcat.tar.gz
rm -rf /opt/tomcat/webapps/examples && \
rm -rf /opt/tomcat/webapps/docs && \
rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/

ENV CATALINA_HOME=/opt/tomcat
ENV EXPORT PATH=$PATH:/opt/tomcat/bin

EXPOSE 8080
EXPOSE 8009
VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
