#!/bin/sh
echo HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
ruby -v
ls -lat
./sea_test "aaa" "aaa"
./sea_test "aaa" "aaa"
./sea_test "aaa" "aaa"
./sea_test "aaa" "fff"
./sea_test "aaa" "bbb"
./sea_test "aaa" "ccc"
./sea_test "aaa" "aaa"
