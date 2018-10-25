#!/bin/bash
`dirname $0`/remove.sh
docker build -t zhanet/wedocr ./
docker images | grep zhanet
