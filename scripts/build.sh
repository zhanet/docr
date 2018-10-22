#!/bin/bash
docker build -t zhanet/wedocr ./
docker images | grep zhanet
