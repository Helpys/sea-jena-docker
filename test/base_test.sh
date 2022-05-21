#!/bin/sh
echo HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
ruby -v
ls -lat
./test/sea_test "aaa" "aaa"
./test/sea_test "aaa" "aaa"
./test/sea_test "aaa" "aaa"
./test/sea_test "aaa" "fff"
./test/sea_test "aaa" "bbb"
./test/sea_test "aaa" "ccc"
./test/sea_test "aaa" "aaa"
