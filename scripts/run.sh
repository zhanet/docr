#!/bin/bash
docker run -d -p 33322:22 --name docr zhanet/docr 2>/dev/null
ssh root@localhost -p 33322
