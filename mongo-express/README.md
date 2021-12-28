1. Create a mongodb deployment file
   we need to check the config of the docker image and setup in the container spec
   we need also to configure a secret component to map with the user and password for mongo
   execute in the terminal `echo -n 'someStringToBeEncoded' | base64`
   to get a encoded value for the username and password.
   The mongo-secret.yaml file must be applied before using it in mongo.yml
   kubectl apply -f mongo-secret.yaml
   then execute the command to create the deploy for mongo
   kubectl apply -f mongo.yaml
2. Create an internal service so other components from other pods can comunicate with the mongodb
   for that we can create a new yaml file or if we put `---` at the end of a yaml block, it means that
   is another file. Thats a feature of yaml files
3. Once defined the Service we need to config the mongo-express Deployment, and in the spec of the template.spec.container
   we will define the env variables. we Need username, password and server, but for that we created 
   a secret component and now a configmap to reuse configuration variables. The ConfigMap needs to be applied
   before applying the mongo-express, so its reference exists before de apply
   `kubectl apply -f mongo-configmap.yaml`
   and `kubectl apply -f mongo-express.yaml`
4. At this point we need to configure a service component over the mongo-express so it gets reached from outside the cluster
   from a web browser. This Service will be set on mongo-express.yaml at the end of the file
   We need to apply the new Service and if we get all the service we will see on the EXTERNAL IP <pending>
   so we need to execute (for minikube) `minikube service mongodb-express-service` note that in a real cluster this will not 
   be necessary. So minikube will expose the service we created

Additionally we can use an Ingress to expose the same app, for that, the file `app-ingress.yaml`
In order to use an ingress we need to enable that plugin for minikube with ```minikube addons enable ingress```
then we can apply the file app-ingress.yaml. With that we will be able to access our mongo-express from outside the cluster
through an ingress thats basically an nginx configuration under the hood. We need to map in the hosts file in the local machine the IP of local k8s `minikube ip` and the host rule defined in the `app-ingress.yaml` in this case `- host: myapp.com`
