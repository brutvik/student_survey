FROM tomcat:latest
COPY /student_survey /usr/local/tomcat/webapps/

EXPOSE 8080
