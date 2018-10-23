#!/bin/bash
docker stop docr
docker rm docr
docker image rm zhanet/wedocr:latest
sed -i '' '/localhost/d' ~/.ssh/known_hosts
# sed -i '/localhost/d' ~/.ssh/known_hosts
