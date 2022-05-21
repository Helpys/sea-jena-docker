#!/bin/sh
echo HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
ruby -v
ls -lat
./test/sea_test.sh "string test words" "aaa" "aaa"
./test/sea_test.sh "string test numbers" "1" "1"
./test/sea_test.sh "number test" 1 1
