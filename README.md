# Deploy AWS EC2 

## Requirement

- Ubuntu linux

- Terraform

```shell
sudo snap install terraform
```

- Ruby

```shell
sudo apt-get update
sudo apt-get install ruby -y
```


## Deploy instruction

### 1. export environment value which is using Terraform

```
export TF_VAR_AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export TF_VAR_AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
export TF_VAR_vpc_addr="${VPCNET}"
export TF_VAR_env="${ENV}"
export TF_VAR_region="us-west-2"
export TF_VAR_ec2_key="<rsa-key-for-ec2>"    
```

### 2. Modify files

For EC2 and Subnet, update `_ec2-list.yml` and `_subnet-list.yml`

Update `var.tf`


### 3. Applying terraform

run shell script.

```
bash _run-tf.sh
```

It will create rsa-key pair which can be access via virtual machines.

