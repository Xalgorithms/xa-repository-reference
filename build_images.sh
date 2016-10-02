#!/bin/bash
if [ "$TRAVIS_BRANCH" == "releases" ]; then
    docker build -t karfai42/xa-repository-reference:production -f Dockerfile.production .
fi

if [ ! -z "$TRAVIS_TAG" ]; then
    docker build -t karfai42/xa-repository-reference:$TRAVIS_TAG -t karfai42/xa-repository-reference:latest -f Dockerfile.production .
fi
