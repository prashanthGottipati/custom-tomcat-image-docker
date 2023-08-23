# Use Tomcat 9 as the base image
FROM tomcat:9.0.79-jdk8-corretto-al2

WORKDIR /usr/local/tomcat

RUN rm -rf webapps && \
	mv webapps.dist webapps

COPY context.xml ./webapps/host-manager/META-INF/context.xml
COPY context.xml ./webapps/manager/META-INF/context.xml
COPY tomcat-users.xml ./conf/tomcat-users.xml 

COPY webapps/works-with-heroku-1.0.war ./webapps/

# Copy your custom tomcat-users.xml file to the container
##COPY tomcat-users.xml $CATALINA_HOME/conf/

# Copy your web application WAR file to the webapps directory
##COPY webapps/works-with-heroku-1.0.war $CATALINA_HOME/webapps/

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
##CMD ["catalina.sh", "run"]





