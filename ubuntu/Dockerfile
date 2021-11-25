ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update && \
    apt-get install -y \
    bash bash-completion ca-certificates lsb-release gnupg\
    wget curl apt-transport-https git \
    unzip rsync vim tmux less jq gettext xclip xsel

RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && \
    git clone https://github.com/tinslice/dotfiles.git ~/.dotfiles && \
    rm -rf ~/.bashrc ~/.profile && cd ~/.dotfiles && ./install && \
    echo "source <(kubectl completion bash)" > ~/.bashrc_local_after

ARG TERRAFORM_VERSION=0.12.25
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./

ARG HELM_VERSION=3.2.1

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && apt-get install azure-cli && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -L https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
    tar xzvf helm.tar.gz && cd linux-amd64 && \
    chmod +x ./* && \
    mv ./helm /usr/local/bin/helm && \
    cd .. && rm -rf linux-amd64 && rm -f helm.tar.gz

WORKDIR /workspace