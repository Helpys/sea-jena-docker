#!/bin/sh
echo HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
ruby -v
ls -lat
./test/sea_test.sh "aaa" "aaa"
./test/sea_test.sh "1" "1"
./test/sea_test.sh 1 1
