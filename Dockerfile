FROM ubuntu:latest AS stage1

RUN apt update && apt install -y git

WORKDIR git

RUN git clone https://github.com/prashanthGottipati/custom-tomcat-image-docker.git

# Use Tomcat 9 as the base image
FROM tomcat:9.0.79-jdk8-corretto-al2 

WORKDIR /usr/local/tomcat

COPY  --from=stage1 /git/custom-tomcat-image-docker/ custom-tomcat-image-docker/

RUN rm -rf webapps && \
	mv webapps.dist webapps && \
	cp ./custom-tomcat-image-docker/context.xml ./webapps/host-manager/META-INF/context.xml && \
	cp ./custom-tomcat-image-docker/context.xml ./webapps/manager/META-INF/context.xml && \
	cp ./custom-tomcat-image-docker/tomcat-users.xml ./conf/tomcat-users.xml && \
	cp ./custom-tomcat-image-docker/webapps/works-with-heroku-1.0.war ./webapps/ && \
	rm -rf ./custom-tomcat-image-docker


# Expose Tomcat port
EXPOSE 8080





