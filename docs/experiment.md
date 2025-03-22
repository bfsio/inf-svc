### Summary

Some experiments were carried out to evaluate a host environment for minikube. The following notes are some data that were collected from the experiments. 

The following environments were evaluated:

- Docker via GitPod
- Windows Home
- Mac Apple Silicon
- Mac Intel x86

### 08-27-2022 17:45 CST

Before the experiment to evalute GitPod as the host for this project, it was known that limitations exist.

```minikube start --driver=none```

For example:

[Minikube inside Docker](https://stackoverflow.com/questions/69771548/how-to-run-minikube-inside-a-docker-container)

[Minikube inside Docker](https://stackoverflow.com/questions/67956247/how-to-run-simple-minikube-inside-docker)

[Can't start minikube inside docker network](https://github.com/kubernetes/minikube/issues/13729)

Therefore, as per known issue [here](https://github.com/bfs-io/gitpod-kubectl-minikube-localstack-aws/issues/3), proceeding with localstack/eks discovery.

After the initial portion of the experiment to evaluate minikube inside Docker via GitPod, it was noted that a possible alternative could be to create and access a local cluster via EKS from localstack, however, upon additional inspection, it was discovered that a license would be required for the feature.

Docker Build

```
docker build -t consumer ./consumer
docker build -t producer ./producer
```

Run localstack

```
DEBUG=1 localstack start
```

-or-

```
docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

From a seperate shell

```
awslocal eks create-cluster --name cluster1 --role-arn r1 --resources-vpc-config '{}'
```

Results in Error

```
An error occurred (InternalFailure) when calling the CreateCluster operation: API action 'CreateCluster' for service 'eks' not yet implemented or pro feature - check https://docs.localstack.cloud/aws/feature-coverage for further information
```

### 08-27-2022 20:40 CST

Some additional experiments were carried out to evaluate on additional platforms. 

M1 MacOS 12.4 for the host environment for this project. The following notes are some data that were collected from the experiments.

```
brew install colima
colima start
minikube start --driver=colima
❌  Exiting due to DRV_UNSUPPORTED_OS: The driver 'colima' is not supported on darwin/arm64
```

```
brew install podman
brew install minikube
podman machine init --cpus 2 --memory 2048 --rootful
podman machine start
minikube start --driver=podman
```

```
% minikube start --driver=podman

😄  minikube v1.26.1 on Darwin 12.4 (arm64)
✨  Using the podman (experimental) driver based on user configuration
📌  Using Podman driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
E0827 21:14:08.568318   21858 cache.go:203] Error downloading kic artifacts:  not yet implemented, see issue #8426
🔥  Creating podman container (CPUs=2, Memory=1956MB) ...
🐳  Preparing Kubernetes v1.24.3 on Docker 20.10.17 ...E0827 21:15:16.695830   21858 start.go:129] Unable to get host IP: RoutableHostIPFromInside is currently only implemented for linux

    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

```
% eval $(minikube podman-env)

❌  Exiting due to MK_USAGE: The podman-env command is only compatible with the "crio" runtime, but this cluster was configured to use the "docker" runtime.
```

**podman-env is requiring crio**
https://github.com/kubernetes/minikube/issues/7709


### 08-28-2022 14:05 CST

Some experiments were carried out to evaluate Mac OS Intel Architecture. The following notes are some data that were collected from the experiments.

```
brew install --cask docker virtualbox 
brew install docker-machine
docker-machine create --driver virtualbox default
docker-machine restart
docker-machine regenerate-certs default
eval "$(docker-machine env default)"
docker-machine restart
docker run hello-world
```

Failing at `docker-machine create`

```
Error creating machine: Error in driver during machine creation: 
Error setting up host only network on machine start: 
The host-only adapter we just created is not visible. 
This is a well known VirtualBox bug. 
You might want to uninstall it and reinstall 
at least version 5.0.12 that is is supposed to fix this issue
```

`virtual box Version 6.1.36 r152435 (Qt5.6.3)`

### 08-28-2022 16:50 CST

Some experiments were carried out to evaluate Windows Home for the host environment for this project. This was evaluated with WSL2 running Ubuntu alongside Windows Docker. The following notes are some data that were collected from the experiments.

```
$ minikube start --driver=docker --delete-on-failure
😄  minikube v1.26.1 on Ubuntu 18.04
✨  Using the docker driver based on user configuration
💣  Exiting due to PROVIDER_DOCKER_VERSION_EXIT_1: "docker version --format -" exit status 1:
📘  Documentation: https://minikube.sigs.k8s.io/docs/drivers/docker/
```
