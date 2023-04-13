FROM tomcat:latest
COPY ../645 /usr/local/tomcat/webapps/

EXPOSE 8080
