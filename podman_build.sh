#!/bin/bash
mkdir build
param=""
if [ "$1" = "--no-cache" ]; then
     param="--no-cache"
fi
podman build $param --layers=false  -t v4l2loopback:latest . -v `pwd`/build:/workdir/build
