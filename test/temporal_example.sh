#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# find latest Junior
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/temporal_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?eventId ?link ?value WHERE {
   << << :employee34 :level \"Junior\" >> seaa:eventId ?eventId >> seaa:deletionTime ?deletionTime .
   FILTER(?deletionTime > NOW())

   << << :employee34 :level \"Junior\" >> seaa:eventId ?eventId >> ?link ?value .
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "00000000-0000-0000-0000-000000000005"

#-------------------------------------------------------------------------------------
# find Senior by request time 2020.07.01
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/temporal_example.ttl
sparql="PREFIX : <http://example.org/>
PREFIX seaa: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?eventId ?link ?value WHERE {
   BIND(\"2020-07-01T00:00:00+02:00\"^^xsd:dateTime as ?requestTime)

   << << :employee34 :level \"Senior\" >> seaa:eventId ?eventId >> seaa:deletionTime ?deletionTime .
   FILTER(?deletionTime > ?requestTime)
   << << :employee34 :level \"Senior\" >> seaa:eventId ?eventId >> seaa:transactionTime ?transactionTime .
   FILTER(?transactionTime < ?requestTime)

   << << :employee34 :level \"Senior\" >> seaa:eventId ?eventId >> ?link ?value .
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "00000000-0000-0000-0000-000000000002"
