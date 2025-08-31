#!/bin/sh
set -ex

docker build --no-cache --progress=plain -t krautsalad/nginx-ldap:latest -f docker/Dockerfile .
docker push krautsalad/nginx-ldap:latest

VERSION=$(git describe --tags "$(git rev-list --tags --max-count=1)")

docker tag krautsalad/nginx-ldap:latest krautsalad/nginx-ldap:${VERSION}
docker push krautsalad/nginx-ldap:${VERSION}
