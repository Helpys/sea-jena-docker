#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/rdf_star_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>

SELECT ?claimer WHERE {
   << :employee38 ?property ?value >> :accordingTo ?claimer
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "employee22"
