# Use the official Tomcat image from Docker Hub
FROM tomcat:9.0

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps/

# Copy your student.war file into the webapps directory of Tomcat
COPY student.war /usr/local/tomcat/webapps/

# Expose port 8080 (where Tomcat will listen)
EXPOSE 8080

# Start the Tomcat server when the container starts
CMD ["catalina.sh", "run"]
