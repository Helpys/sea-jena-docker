#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"
echo "-------------------------------------------------------------------------------"

echo "-------------------------------------------------------------------------------"
# apache_jena_script/s-delete "http://localhost:3030/dataset/data" "default"
# apache_jena_script/s-query --service="http://localhost:3030/dataset/query" "SELECT * {?s ?p ?o}"
result=$(bin/s-delete "http://localhost:3030/dataset/data" "default")
echo $result | assert_contains "Spiderman"
