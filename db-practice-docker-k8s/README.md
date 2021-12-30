# Database practice with docker kubernetes postgres and pgadmin
This practice will have a docker postgres instance connected to a kubernetes cluster
I will use an ingress to map the traffic to a Service then to the Deployment, that will contain an abstraction layer
for a pgAdmin client.

## Part 1
Create the docker-compose file to create the postgres volume

## Part 2
Setup the components for the kubernetes cluster (Deployment, Service, Ingress) and also
build the iamge for the pgadmin client

## Create ConfigMap and Secret
Put in the ConfigMap the basic configuration data, and use the Secret to store the password for the database connection

# Considerations
1. I had issues connecting the dockerized docker with the dockerized minikube, so I had to run minikube with VirtualBox

https://minikube.sigs.k8s.io/docs/drivers/

```minikube start --driver=virtualbox``` 

Then I got the postgres container IP
```docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-ip>```
this is the IP I used to configure the host in the pgadmin inside kubernetes

2. I enabled the ingress addon to get the ingress up and running

```minikube addons enable ingress```

3. I needed to map the minikube IP with the url defined in the ingress host, the mapping is locally done in the /etc/hosts file

```minikube ip``` : 192.168.59.101

and then map in the hosts

```192.168.59.101 pgadminclient.com```
