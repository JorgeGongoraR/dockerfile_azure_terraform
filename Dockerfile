FROM centos:latest
ENV TERRAFORM_VERSION=0.15.0

#Install dependencies 
RUN yum install wget unzip -y && \
    yum update -y && \
    yum install python3 -y && \
    yum install python3-pip -y 

#Install azure-cli
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc

RUN echo -e $"[azure-cli] \n\
name=Azure CLI \n\
baseurl=https://packages.microsoft.com/yumrepos/azure-cli \n\
enabled=1 \n\
gpgcheck=1 \n\
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee etc/yum.repos.d/azure-cli.repo
RUN yum install azure-cli -y && \
    az --version

# Install terraform
RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/terraform  && \
    terraform --version
