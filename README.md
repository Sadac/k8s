# Kubernetes practice
Create a node app inside kubernetes that queries a database outside the cluster, the database will be hosted in a docker container

The Node app with an express server will create and read users. A path or url must be provided so a client can create and read users from the database

### Building the Docker Image
Once we have the files of the Node application, we can "Dockerize" it. for that we need:
1. Create a Dockerfile in the root of the project and type the instructions to build the image (see Dockerfile)
2. Create a .dockerignore to list the folders and files we want to ignore when copying in the image creation
3. Execute the command ```docker build -t rocco/demoapp ./``` to build the image

### Running the Docker Image
We can run the docker image with an inline command like so:
```docker run -p 5000:8080 rocco/demoapp``` to run the image and map the local port 5000 to the container port 8080

But the best way would be to create a docker-compose.yaml file and set the isntructions to run the image
```yaml
version: "3.8"

services:
  web:
    # build: ./
    image: rocco/demoapp # the name of the previous built image in step 3
    ports:
      - 5000:8080
```
But also we can specify to build the image with whe prop `build: ./` and that will execute the Dockerfile as well. So we cant avoid execute the docker build and the docker run, instead we can execute `docker-compose up -d`