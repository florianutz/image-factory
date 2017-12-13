#!/bin/bash
cd /tmp
curl -qL -o packer_${PACKER_VERSION}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
curl -qL -o packer_${PACKER_VERSION}_SHA256SUMS https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS
sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
#ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
#ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./
#RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
#RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
#RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
