#!/bin/sh

echo "load standard turtle example"
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
docker exec $(docker ps -q) bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
./test/sea_test "xx" "xx"
