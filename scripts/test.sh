#!/bin/bash

docker exec -it docr tesseract \-v
docker exec -it docr tesseract \--list-langs

# Base OCR test
docker exec -it docr /bin/bash -c "echo +++; mkdir ./ocr-files/; cd ./ocr-files/; pwd; rm phototest.*; echo +++; \
wget -O phototest.tif https://github.com/tesseract-ocr/test/raw/master/testing/phototest.tif; \
tesseract phototest.tif phototest; \
head -100 phototest.txt; \
echo Compare the text above ^^^ with the source image: \ 
echo https://github.com/tesseract-ocr/test/raw/master/testing/phototest.tif"
