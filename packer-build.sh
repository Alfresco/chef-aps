#!/bin/bash

date +"%R STARTING BUILD"

APS_PATH="/tmp/packer/chef-aps"
COOKBOOK_PATHS="$APS_PATH/cookbooks"
DATA_BAGS_PATH="$APS_PATH/data_bags"

DATA_BAGS_URL="https://artifacts.alfresco.com/nexus/content/repositories/internal-releases/org/alfresco/devops/alfresco-databags/0.2.21/alfresco-databags-0.2.21.tar.gz"

if [ -d $APS_PATH ]
  then rm -rf $APS_PATH/*
  else mkdir -p $APS_PATH
fi

mkdir -p $COOKBOOK_PATHS $DATA_BAGS_PATH

export GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export DATABAGS_FOLDER_PATH=$DATA_BAGS_PATH
export COOKBOOK_FOLDER_PATH=$COOKBOOK_PATHS
export VPCID="vpc-bc2f9ad9"
export AWS_REGION="us-east-1"
export AMI_ID="ami-6d1c2007"
export SECURITY_GROUP_IDS="sg-85540bfb"
export SUBNET_ID="subnet-58d82f01"

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  while [ -z "$AWS_ACCESS_KEY_ID" ]; do
    printf '%s ' 'Insert valid AWS ACCESS KEY '
    read AWS_ACCESS_KEY_ID
    export AWS_ACCESS_KEY_ID
  done
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  while [ -z "$AWS_SECRET_ACCESS_KEY" ]; do
    printf '%s ' 'Insert valid AWS SECRET KEY '
    read -s AWS_SECRET_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY
  done
fi

if [ -z "$MVN_CHEF_REPO_USERNAME" ]; then
  while [ -z "$MVN_CHEF_REPO_USERNAME" ]; do
    printf '%s ' 'Insert valid maven username '
    read MVN_CHEF_REPO_USERNAME
    export MVN_CHEF_REPO_USERNAME
  done
fi
if [ -z "$MVN_CHEF_REPO_PASSWORD" ]; then
  while [ -z "$MVN_CHEF_REPO_PASSWORD" ]; do
    printf '%s ' 'Insert valid maven password '
    read -s MVN_CHEF_REPO_PASSWORD
    export MVN_CHEF_REPO_PASSWORD
  done
fi

curl -u $MVN_CHEF_REPO_USERNAME:$MVN_CHEF_REPO_PASSWORD -o $APS_PATH/alfresco-databags.tar.gz $DATA_BAGS_URL
tar -xvzf $APS_PATH/alfresco-databags.tar.gz -C $APS_PATH
rm -f $APS_PATH/alfresco-databags.tar.gz

rm -f Berksfile.lock
berks vendor $COOKBOOK_PATHS

packer validate packer/img-aps-postgres-packer.json
packer validate packer/img-aps-mysql-packer.json

#packer build -debug packer/img-aps-packer.json | gawk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }'
packer build packer/img-aps-postgres-packer.json
# packer build -debug -on-error=ask packer/img-aps-mysql-packer.json 
