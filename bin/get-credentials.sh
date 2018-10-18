#!/bin/sh
[ -n "$ECR_REGISTRY_IDS" ] && export PLUGIN_REGISTRY_IDS=${ECR_REGISTRY_IDS}

# support --registry-ids if provided
[ -n "$PLUGIN_REGISTRY_IDS" ] && export REGISTRY_IDS="--registry-ids ${PLUGIN_REGISTRY_IDS} "

# get token from aws
aws_auth=$(aws ecr get-authorization-token --output text ${REGISTRY_IDS:-''})
DOCKER_PASSWORD=$(echo $aws_auth | cut -d ' ' -f2 | base64 -d | cut -d: -f2)
echo "DOCKER_USERNAME=AWS" >> .env
echo "DOCKER_PASSWORD=${DOCKER_PASSWORD}" >> .env