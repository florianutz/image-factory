#!/bin/sh
cd /tmp
echo "Downloding Packer"
curl -qL -o packer_${PACKER_VERSION}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
echo "Downloding Packer Checksum"
curl -qL -o packer_${PACKER_VERSION}_SHA256SUMS https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS
sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
echo "Verify Packer"
sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS
echo "Installing Packer ..."
unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
echo "Removing temporary files"
rm -f packer_${PACKER_VERSION}_linux_amd64.zip packer_${PACKER_VERSION}_SHA256SUMS
