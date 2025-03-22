# Infra Services Research Project

## Overview

### Prepping your environment to run this project

__To satisify the ephemeral NFR__

(See Experiment below) 
Getting minikube to run in Docker someday 🤷‍♂️ - or Maybe k3s can help - 🙋‍♂️ - Vagrant is a fine tool for now.

[Installing Vagrant](https://www.vagrantup.com/docs/installation)

[Vagrantfile](https://github.com/mhackersu/infra-services-tech-interview-project/blob/master/infra/Vagrantfile)

```
$ cd infra/Vagrantfile && vagrant up
```

### Installation

We are a Docker and Kubernetes shop at BFS.  We utilize Amazon EKS for our hosted Kubernetes solution. For this exercise, we want you to install Docker and Minikube on your local machine, and emulate a service-to-service process.  Please follow the instructions below.  If there are issues with the installation, please reach out to us.

**NOTE**: If you have `kubectl` installed, you may need to update it to work with `minikube`, as it installs the latest stable release of Kubernetes.  When you start the cluster up, `minikube` will switch your cluster context.  If you do not have `kubectl` installed, `minikube` _should_ install it with the latest stable release.  

- [Docker Installation Instructions](https://docs.docker.com/compose/install/)
- [Minikube Installation Instructions](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl Installation Instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

With our tools installed, we will use `minikube` to create a one node cluster and use `kubectl` to deploy our services.

### Cluster Setup
In a terminal or shell run the following to build the cluster:
```
minikube start
```

You should be good to go when you see this output:

```
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

#### Building Images with Docker and Minikube
Minikube offers a Docker daemon inside the cluster we can use to push images to.  This allows us to skip publishing images to a Docker registry.  To point to this cluster docker daemon, use the following:

```
eval $(minikube docker-env)
```

Now any `docker` command run will run against the daemon inside the cluster.  We can test this with `docker ps` to see all the containers inside minikube and virtual machine.  Note that this only works in the current shell you have open.  If you open a new terminal window, you'll have to re-run it.

Now we can build our containers.  From the root project directory:

```
docker build -t consumer candidate-project/consumer
docker build -t producer candidate-project/producer
```

#### Simulating AWS Infrastructure
We are using Localstack to emulate an AWS environment.  In this case, we're setting up three resources: an SNS Topic, an SQS queue, and a subscription for the queue to the topic.  Any messages published to the topic will go to all the subscribers; in this case, the queue will get a copy of the message.


#### Deploying to Kubernetes

To deploy, run the following:

```
kubectl apply -f candidate-project/kubernetes
```

This will deploy `localstack`, and setup the API for our mock AWS infrastructure, along with the `producer` and `consumer` services.

Once everything is deployed, we can use `kubectl` to verify the pods are running, and behaving as expected. To verify the pods are running, the use following:

```
kubectl get pods
```

The output here should display three running pods. You can further dig into the pod setup with:

```
kubectl describe pod $POD_NAME
```

This will give you really detailed info on the pods, including the events like startup, pulling the container image, and more.  Next, check out the logs for each pod:

```
kubectl logs $POD_NAME
```

We should see logs in the `producer` related to publishing messages, and logs in the `consumer` related to receiving them, logging the contents, and deleting them.

### Exercise Overview

We want to implement some resiliency into our cluster.  We'll start by adding a liveness probe to both `consumer` and `producer` deployments.  In both projects, you can see a `server.py` that creates a simple HTTP Server in Python.  When the `/health` endpoint is hit, it should return an HTTP status code of `200` and a message body of `{ "status": "UP!" }`.  We run this server in the `app.py` file for both services.

To test that the server is up and running, you can use `kubectl exec` like so:

```
kubectl exec $POD_NAME -- curl http://0.0.0.0:5000/health
```

This will execute a shell command, namely `curl`, on the pod.  If all goes well, we should get back the message we expect.  However, this is a manual process to let us know if the pod is healthy or not.  To have Kubernetes automate this for us, we can have it use a liveness probe to periodically hit this endpoint.  If the endpoint returns a non successful response code (i.e. >200), and it meets the default `failureThreshold` of 3, the liveness probe will fail and Kubernetes will restart the pod. You can observe this behavior by renaming the endpoint or port, and seeing how Kubernetes handles it.

You can learn more about probes in the Kubernetes docs: [Configuring Liveness, Readiness, and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

### Completing the Exercise

Once the probe is up and running, you should be able to run `kubectl logs` on both running `consumer` and `producer` pods and see logs like this:

```
172.17.0.1 - - [30/Jan/2021 00:25:58] "GET /health HTTP/1.1" 200 -
```

 Once you're at a stopping point and your documentation is ready, please submit the project via the GreenHouse link provided in the original email (if there are any issues with the link, please send us an email with the document attached {format is up to you}).  After we receive it, we'll take a look.

### Resource Cleanup
You can tear down the cluster with:

```
minikube stop
minikube delete
```
