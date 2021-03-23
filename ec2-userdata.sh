#!/bin/bash -v

sleep 120

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install resolvconf -yq
echo "search "test-jhp0204.lab.io"" > /etc/resolvconf/resolv.conf.d/base
resolvconf -u

# create ansible user
groupadd ansible
useradd -g ansible -m -s /bin/bash ansible
su - ansible -c "mkdir -m 700 .ssh"
su - ansible -c "echo \"abc\" >> /home/ansible/.ssh/authorized_keys"
su - ansible -c "echo -e \"\\n\" >> /home/ansible/.ssh/authorized_keys"
su - ansible -c "chmod 600 /home/ansible/.ssh/authorized_keys"
echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users

# Install Default package
DEBIAN_FRONTEND=noninteractive apt-get install -yq python
