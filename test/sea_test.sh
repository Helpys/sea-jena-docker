#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/sea_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?decisionTime WHERE {
   << :employee38 :familyName \"Smith\" >> seaa:decisionTime ?decisionTime
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "employee22"
