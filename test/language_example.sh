#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# find all translations
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/language_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?name ?lang WHERE {
   << << :animal34 :name ?name >> seaa:eventId ?eventId >> seaa:transactionTime ?value .
  BIND(lang(?name) as ?lang)
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "Schmetterling"
