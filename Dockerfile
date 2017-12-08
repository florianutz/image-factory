FROM alpine:latest
MAINTAINER "Florian"
RUN \
	apk add --no-cache python py-pip && \
	pip install awscli && \
	apk del --purge py-pip && \
	rm /var/cache/apk/*

ENV PACKER_VERSION=1.1.2
ENV PACKER_SHA256SUM=7e315a6110333d9d4269ac2ec5c68e663d82a4575d3e853996a976875612724b

RUN apk add --update git bash wget openssl

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/sh"]
