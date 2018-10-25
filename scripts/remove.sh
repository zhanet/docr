#!/bin/bash
docker stop docr >/dev/null 2>&1
docker rm docr >/dev/null 2>&1
docker image rm zhanet/wedocr:latest >/dev/null 2>&1
