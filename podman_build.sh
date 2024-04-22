#!/bin/bash
mkdir build
param=""
if [ "$1" = "--no-cache" ]; then
     param="--no-cache"
fi
podman build $param -t v4l2loopback:latest . -v `pwd`/build:/v4l2loopback/build
