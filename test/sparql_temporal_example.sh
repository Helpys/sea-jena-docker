#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# validate Bar class
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-delete "http://localhost:3030/dataset/data" "default"
bin/s-put http://localhost:3030/dataset/data default test/sparql_temporal_example.ttl

sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?s ?p ?o WHERE {
   ?tt seaa:transactionTime ?transactionTime
   BIND(SUBJECT(?tt) as ?t)
   BIND(SUBJECT(?t) as ?s)
   BIND(PREDICATE(?t) as ?p)
   BIND(OBJECT(?t) as ?o)
}"
result=$(bin/s-query --service http://localhost:3030/dataset/query "$sparql")
echo $result | assert_contains "Switzerland"
echo $result | assert_contains "Schweiz"

# apache_jena_script/s-delete "http://localhost:3030/dataset/data" "default"
# apache_jena_script/s-query --service="http://localhost:3030/dataset/query" "SELECT * {?s ?p ?o}"
# curl -XPOST --data-binary @test/shacl_sparql_temporal_example.shacl.ttl --header 'Content-type: text/turtle' 'http://localhost:3030/dataset/shacl?graph=default'
