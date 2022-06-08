#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"
echo "-------------------------------------------------------------------------------"
cat ./test/turtle_example.ttl | assert_contains "www"

echo "-------------------------------------------------------------------------------"
bin/s-delete "http://localhost:3030/dataset/data" "default"
bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
result=$(bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}')
echo $result | assert_contains "Spiderman"

echo "-------------------------------------------------------------------------------"
result=$(bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}")
echo $result | assert_contains "Green[[:space:]]Goblin"
