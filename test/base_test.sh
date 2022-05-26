#!/bin/dash
. ./test/sea_test.sh


echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"
echo "-------------------------------------------------------------------------------"
cat ./test/turtle_example.ttl | assert_contains "www"

echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
result=$(bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}')
echo $result | assert_contains "Spiderman"

echo "-------------------------------------------------------------------------------"
result=$(bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}")
echo "result s-query='$result'"
echo $result | assert_contains "Green Goblin"
