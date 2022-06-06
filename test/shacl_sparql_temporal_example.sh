#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# validate Bar class
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-delete "http://localhost:3030/dataset/data" "default"
bin/s-put http://localhost:3030/dataset/data default test/shacl_sparql_temporal_example.ttl

result=$(curl -XPOST --data-binary @test/shacl_sparql_temporal_example.shacl.ttl  \
     --header 'Content-type: text/turtle' \
     'http://localhost:3030/dataset/shacl?graph=default')

echo "XXX-------------------------------------------------------------------------------"
echo $result
echo "XXX-------------------------------------------------------------------------------"
echo $result | assert_contains "false"
echo $result | assert_contains "\"Spain\"@en"

# apache_jena_script/s-delete "http://localhost:3030/dataset/data" "default"
# apache_jena_script/s-query --service="http://localhost:3030/dataset/query" "SELECT * {?s ?p ?o}"
curl -XPOST --data-binary @test/shacl_sparql_temporal_example.shacl.ttl --header 'Content-type: text/turtle' 'http://localhost:3030/dataset/shacl?graph=default'
