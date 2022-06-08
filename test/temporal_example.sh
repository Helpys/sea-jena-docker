#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# find latest Junior
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-delete "http://localhost:3030/dataset/data" "default"
bin/s-put http://localhost:3030/example/data default test/temporal_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
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
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
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

#-------------------------------------------------------------------------------------
# find level by request- and intrest time 2021.07.11
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/temporal_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

SELECT ?eventId ?level ?link ?value WHERE {
   BIND(\"2021-07-11T00:00:00+02:00\"^^xsd:dateTime as ?requestTime)

   << << :employee34 :level ?level >> seaa:eventId ?eventId >> seaa:deletionTime ?deletionTime .
   FILTER(?deletionTime > ?requestTime)
   << << :employee34 :level ?level >> seaa:eventId ?eventId >> seaa:transactionTime ?transactionTime .
   FILTER(?transactionTime < ?requestTime)
   << << :employee34 :level ?level >> seaa:eventId ?eventId >> seaa:validFrom ?validFrom .
   FILTER(?validFrom < ?requestTime)
   << << :employee34 :level ?level >> seaa:eventId ?eventId >> seaa:validTo ?validTo .
   FILTER(?validTo > ?requestTime)

   << << :employee34 :level ?level >> seaa:eventId ?eventId >> ?link ?value .
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "Junior"
