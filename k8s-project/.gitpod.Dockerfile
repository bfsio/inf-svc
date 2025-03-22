# GitPod Base Workspace
FROM gitpod/workspace-full:latest

# Set Working Directory
WORKDIR /usr/src/app

# Install localstack
RUN pip install localstack awscli awscli-local pybuilder

# Get kubectl binary
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Get kubectl checksum
RUN curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Validate kubectl checksum result (kcr)
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install kubectl
RUN sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Output kubectl version
RUN kubectl version --client

# Install Helm
RUN brew install helm

# Install Minikube
RUN brew install minikube

# Install TF
RUN brew install terraform

# # TF Start
# # Install tools as the gitpod user
# USER gitpod
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# # Install helper tools
# RUN brew update && brew upgrade && brew install \
#     gawk coreutils pre-commit tfenv terraform-docs \
#     tflint tfsec instrumenta/instrumenta/conftest \
#     && brew install --ignore-dependencies cdktf \
#     && brew cleanup
# RUN tfenv install latest && tfenv use latest
# COPY .gitpod.bashrc /home/gitpod/.bashrc.d/custom
# # Give back control
# USER root
# #  and revert back to default shell
# #  otherwise adding Gitpod Layer will fail
# SHELL ["/bin/sh", "-c"]
# # TF End

# Install TRDL
# RUN pip3 install trdl

# Add Werf repo to trdl
# RUN trdl add werf https://tuf.werf.io 1 b7ff6bcbe598e072a86d595a3621924c8612c7e6dc6a82e919abe89707d7e3f468e616b5635630680dd1e98fc362ae5051728406700e6274c5ed1ad92bea52a2

# Activate Werf for new shell
# RUN source "$(trdl use werf 1.2 stable)"
