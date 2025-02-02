#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

echo "-------------------------------------------------------------------------------"
apache_jena_script/s-delete "http://localhost:3030/example/data" "default"
apache_jena_script/s-put http://localhost:3030/example/data default test/sea_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?decisionTime WHERE {
   << :employee38 :familyName \"Smith\" >> seaa:decisionTime ?decisionTime
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "2020-01-01T17:07:07+02:00"

echo "-------------------------------------------------------------------------------"
apache_jena_script/s-put http://localhost:3030/example/data default test/sea_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?employee WHERE {
   << ?employee :familyName \"Smith\" >> seaa:transactionTime ?transactionTime
  FILTER(?transactionTime < NOW() )
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo "*********************************************"
echo $result
echo "*********************************************"
echo $result | assert_contains "employee38"
