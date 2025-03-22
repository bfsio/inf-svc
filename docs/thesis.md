## Working Thesis

__Hypothesis__

[Production Parody & Cost Relationship](./production-parody-cost-relationship.png)

__Research__
- [Software engineering is a trainwreck](https://news.ycombinator.com/item?id=27892615)
- [Cost to fix defect in production 100x "study may not exist"](https://news.ycombinator.com/item?id=27917595)
- [Leprechauns of Software Engineering](https://gist.github.com/Morendil/258a523726f187334168f11fc8331569)

This working thesis section was developed to organize work conducted on this project. 

Before any work was carried out, a Wardley Map was created.

### [Wardley Map](https://miro.com/app/board/uXjVPc3LhJ8=/?share_link_id=57127044538)

Secondly, before any experiments were created, a review of the project and code base was conducted. What was immediatly evident, is that most likely, a Linux environment with Intel or AMD hardware would be required to complete the exercise, therefore the work was divided into two parts. 

The first half of the experiment was spent defining non-functional requirements. The second-half of the experiment was spent developing stepwise CLI commands integrated to the Docker daemon inside a minikube cluster that publishes applications to nodes.

### [Deployment Architecture Deck](k8s_deployment_architecture.pdf)

### [True Delivery Feature](https://github.com/mhackersu/infra-services-tech-interview-project/blob/feature/trdl/werf.yaml)

From a developer experience perspective, edge cases were developed that represent possible environments that developers may be using, attempting to use, or limited to the use thereof, for the attainment of interaction with the infrastructure services local stack.

An ephemeral environment was provisioned for the first experiement.

#### Ephemeral GitPod Environment
[![Open in Gitpod](https://img.shields.io/badge/Gitpod-with--prebuild-blue?logo=gitpod)](https://gitpod.io/#https://github.com/mhackersu/infra-services-tech-interview-project)

### [Experimentation Report](https://github.com/mhackersu/infra-services-tech-interview-project/blob/master/experiment.md)

- Next experiment, looking into k3s

## Summary of Working Thesis

It was a pleasure to work with this project. This project was documented well and the installation for tooling was presented in a clear and easy to follow manner. This project seems like it would be a good canidate for an official incubator project.

## End of Working Thesis

The Infrastructure Services group uses this homework exercise to give candidates an idea of the work we do, as well as help us understand how candidates plan and execute work.
