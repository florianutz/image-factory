FROM alpine:3.7
MAINTAINER "Florian Utz"

ENV PACKER_VERSION=1.1.3
ENV PACKER_SHA256SUM=b7982986992190ae50ab2feb310cb003a2ec9c5dcba19aa8b1ebb0d120e8686f
########
RUN echo "===> Adding Python runtime..."  && \
    apk --no-cache add python python3 py-pip openssl ca-certificates sudo groff   && \
    apk --no-cache add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi                            && \
    \
    echo "===> Installing Ansible..."  && \
    pip install --upgrade ansible                && \
    \
    echo "===> Installing awscli..."  && \
    pip install --upgrade awscli                && \
    \
    echo "===> Adding some tools..." && \
    apk add --no-cache git wget openssl curl jq && \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    echo "===> Package installation completed!"



#######
#RUN \
#     apk add --no-cache python py-pip && \
#     pip install awscli



#RUN apk add --no-cache git wget openssl curl jq

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
#RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip
#RUN curl -qL -o /usr/local/bin/jq https://stedolan.github.io/jq/download/linux64/jq && chmod +x /usr/local/bin/jq
###
RUN adduser -D imagefactory && mkdir /data && chown imagefactory:imagefactory /data && chmod 770 /data
USER imagefactory
WORKDIR /data
###
ENTRYPOINT ["/bin/sh"]
