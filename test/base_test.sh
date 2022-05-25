#!/bin/sh
source sea_test.sh



echo "-------------------------------------------------------------------------------"
ls -lat
echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"
cat ./test/turtle_example.ttl | assert_contains "w2ww"
echo "-------------------------------------------------------------------------------"

# bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
# bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
# echo "----------"
# result=$(bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}")
# echo "result s-query='$result'"
# echo "----------"
#
# f_contains $result "Green Goblin"
