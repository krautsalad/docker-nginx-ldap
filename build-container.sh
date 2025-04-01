#!/bin/sh
set -ex
docker build --no-cache --progress=plain -t krautsalad/nginx-ldap:latest -f Dockerfile .
