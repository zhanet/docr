#!/bin/bash
docker run -d -p 33322:22 --name docr zhanet/wedocr 2>/dev/null
# sed -i '/localhost/d' ~/.ssh/known_hosts
sed -i '' '/33322/d' ~/.ssh/known_hosts
ssh root@localhost -p 33322
