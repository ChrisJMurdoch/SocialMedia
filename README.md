
# Picturn

3rd-year social media group coursework.

View live at https://picturn.herokuapp.com

## Installing locally

Git, Maven, and Eclipse EE are required to install and edit the project.

*Git is available to download at https://git-scm.com/downloads*

*Maven can be downloaded at https://maven.apache.org/download.cgi and help on installing can be found at https://www.baeldung.com/install-maven-on-windows-linux-mac*

*Eclipse EE and can be downloaded at https://www.eclipse.org/downloads*

### Clone the repository using Git

Navigate to the directory you'd like to import to and in the Git bash, run:

> git clone https://github.com/ChrisJMurdoch/SocialMedia.git

This will give you a maven-structure project.

### Use Maven to convert the project

Navigate to the directory using the command line and type:

> mvn eclipse:eclipse -Dwtpversion=2.0

This will convert the maven project into an Eclipse dynamic web application.

### Import the project with Eclipse

In Eclipse, go to:

> Import > General > Existing Projects into Workspace

Select the root directory of the project and click finish.

## Running the project

Apache Tomcat v9.0 is required to run the project locally and can be downloaded at https://tomcat.apache.org/download-90.cgi

### Configuring the project

Use Maven to install dependencies and configure the project:

> mvn package

This will generate the WAR file required by Tomcat.

### Starting the server

Start the server with the command:

> java -jar target/dependency/webapp-runner.jar target/*.war

This tells webapp-runner.jar to build and run the WAR file.  The server will now be listening on port 8080.

## Viewing

The main branch is persistently hosted at: https://picturn.herokuapp.com

To view the local server's output, go to http://localhost:8080
