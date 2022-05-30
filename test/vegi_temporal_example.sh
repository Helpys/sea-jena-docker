#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# find latest Junior
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/example/data default test/vegi_temporal_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xml: <http://www.w3.org/XML/1998/namespace>

SELECT DISTINCT ?s1 ?s2 ?s3 WHERE {
  BIND(\"2021-07-01T00:00:00+02:00\"^^xsd:dateTime as ?requestTime)

  << << ?s1 rdfs:subClassOf <Vegetable> >> seaa:eventId ?eventId1 >> seaa:deletionTime ?deletionTime1 ;
  																	 seaa:transactionTime ?transactionTime1 .
  FILTER((?deletionTime1 > ?requestTime) && (?transactionTime1 < ?requestTime))

  OPTIONAL{
    << << ?s2 rdfs:subClassOf ?s1 >> seaa:eventId ?eventId2 >>  seaa:deletionTime ?deletionTime2 ;
																seaa:transactionTime ?transactionTime2 .
	FILTER((?deletionTime2 > ?requestTime) && (?transactionTime2 < ?requestTime))

    OPTIONAL{
          << << ?s3 rdfs:subClassOf ?s2 >> seaa:eventId ?eventId3 >>  seaa:deletionTime ?deletionTime3 ;
                                                                      seaa:transactionTime ?transactionTime3 .
    FILTER((?deletionTime3 > ?requestTime) && (?transactionTime3 < ?requestTime))
  	}
  }
}"
result=$(bin/s-query --service http://localhost:3030/example/query "$sparql")
echo $result | assert_contains "Legumes"
