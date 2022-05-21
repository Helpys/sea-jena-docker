#!/bin/sh
echo HelloWorld
docker exec $(docker ps -q) ruby -v
docker exec $(docker ps -q) ls -lat
docker exec $(docker ps -q) echo HELLO-WORLD
docker exec $(docker ps -q) ls -lat test
docker exec $(docker ps -q) ls -lat bin
docker exec $(docker ps -q) ls -lat configuration
test -f && echo "ok" || echo "test fail"
