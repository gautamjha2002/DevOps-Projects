# Welcome to Continous Delivery with Jenkins

This project has a CI/CD pipeline set up using Jenkins. The pipeline does the following:

1. Fetch the code from the repository
2. Build the code using Maven
3. Run tests on the code
4. Perform code analysis using Checkstyle
5. Deploy the app on a Docker container using Docker Compose

### Prerequisites
* Java
* Maven
* Jenkins
* Docker

## Setting up the pipeline

1. Install Jenkins on your machine.
2. Create a new Jenkins job and configure the job to pull the code from the repository.
3. And every this is done by defined Jenkinsfile

NOTE :- you need to change the Dockerimage name in docker-compose file in the Application directory

## Running the pipeline
To run the pipeline, simply trigger a build on the Jenkins job. The pipeline will automatically fetch the code, build it, test it, perform code analysis, and deploy it on the Docker container.

### Notes
The pipeline is currently set up to run on the same machine as Jenkins. If you want to deploy to a different machine, you will need to modify the deployment step.

To keep up with updates on this project and my other work, follow me on Twitter and LinkedIn:

Twitter: [@Gautam31012002](https://twitter.com/Gautam31012002)

LinkedIn: [@gautam-devops](https://www.linkedin.com/in/gautam-devops/)