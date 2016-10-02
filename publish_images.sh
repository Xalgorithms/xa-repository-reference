#!/bin/bash
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push karfai42/xa-repository-reference:production
if [ ! -z "$TRAVIS_TAG" ]; then
    docker push karfai42/xa-repository-reference:$TRAVIS_TAG
    docker push karfai42/xa-repository-reference:latest
fi
