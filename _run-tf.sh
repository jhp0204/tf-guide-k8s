#!/bin/bash

# create ansible keypair
if [ ! -f ./ansible_rsa.pub ]; then
    ssh-keygen -b 2048 -t rsa -f ansible_rsa -q -N "" -C ""
fi
export TF_VAR_ansible_rsa_pub="$(cat ./ansible_rsa.pub)"

# create terraform template
erb _ec2-create-list.erb > ec2-all.tf
erb _subnet-create-list.erb > subnet-all.tf

# terraform init
terraform init

# run terraform
terraform apply
