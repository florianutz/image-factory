FROM ubuntu:16.04
LABEL maintainer="Florian Utz"

ENV PACKER_VERSION=1.1.3
ENV PACKER_SHA256SUM=b7982986992190ae50ab2feb310cb003a2ec9c5dcba19aa8b1ebb0d120e8686f

RUN echo "===> Install packages ..."  && \
    apt update && apt upgrade -y   && \
    apt install --no-install-recommends -y python3 python3-setuptools python3-pip openssl ca-certificates sudo groff \
        python3-dev libffi-dev libssl-dev build-essential \
        git wget openssl curl jq unzip && \
    echo "===> Cleanup" && \
    apt clean all && \
    echo "===> Package installation completed!"

RUN echo "===> Install python packages ..."  && \
    pip3 install --no-cache-dir --upgrade pip cffi && \
    \
    echo "===> Installing Ansible..."  && \
    pip3 install --no-cache-dir --upgrade ansible && \
    \
    echo "===> Installing awscli..."  && \
    pip3 install --no-cache-dir --upgrade awscli

COPY setup-packer.sh /usr/local/bin/
RUN /usr/local/bin/setup-packer.sh

# Install Ansible inventory file
RUN echo '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

RUN useradd -m imagefactory && mkdir /data && chown imagefactory:imagefactory /data && chmod 770 /data
USER imagefactory
WORKDIR /data
###
CMD ["/bin/bash"]
