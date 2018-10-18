#!/bin/sh
[ -n "$ECR_REGISTRY_IDS" ] && export PLUGIN_REGISTRY_IDS=${ECR_REGISTRY_IDS}
[ -n "$ECR_REGION" ] && export PLUGIN_REGION=${ECR_REGION}
# support --registry-ids if provided
[ -n "$PLUGIN_REGISTRY_IDS" ] && export REGISTRY_IDS="--registry-ids ${PLUGIN_REGISTRY_IDS} "

# set the region
export AWS_DEFAULT_REGION=${PLUGIN_REGION:-'us-east-1'}

# get token from aws
aws_auth=$(aws ecr get-authorization-token --output text ${REGISTRY_IDS:-''})
DOCKER_PASSWORD=$(echo $aws_auth | cut -d ' ' -f2 | base64 -d | cut -d: -f2)
echo $DOCKER_PASSWORD
echo "DOCKER_USERNAME=AWS" >> .env
echo "DOCKER_PASSWORD=$DOCKER_PASSWORD" >> .env