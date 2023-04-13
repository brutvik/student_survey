FROM tomcat:latest
COPY . /usr/local/tomcat/webapps/

EXPOSE 8080
