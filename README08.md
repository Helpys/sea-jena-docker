- name: Test jena-fuseki usind SOH
  env:
    SSH_AUTH_SOCK: /tmp/ssh_agent.sock
  run: |
    ssh -o StrictHostKeyChecking=no root@${{ secrets.DIGITAL_OCEAN_IP_ADDRESS }} << 'ENDSSH'
      cd /app
      source .env
      echo XXXXXXX01
      docker exec $(docker ps -q) test -f && echo "yes" || echo "no"
      docker exec $(docker ps -q) ruby -v
      docker exec $(docker ps -q) ls -lat
      docker exec $(docker ps -q) echo HELLO-WORLD
      docker exec $(docker ps -q) ls -lat test
      docker exec $(docker ps -q) ls -lat bin
      docker exec $(docker ps -q) ls -lat configuration
      docker exec $(docker ps -q) echo DIGITAL_OCEAN_IP_ADDRESS ==> ${{ secrets.DIGITAL_OCEAN_IP_ADDRESS }}
      docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
      docker exec $(docker ps -q) bin/s-get http://localhost:3030/example/data default
      docker exec $(docker ps -q) bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
      docker exec $(docker ps -q) test/base_test.sh
      echo YYYYYYY02
    ENDSSH


docker exec $(docker ps -q) test/base_test.sh | xargs -I % test % = "ok" && echo "OKIDOKI" || echo "NONONO"



EBASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xml: <http://www.w3.org/XML/1998/namespace>

SELECT DISTINCT ?s1 ?s2 ?s3 WHERE {
  BIND("2020-07-01T00:00:00+02:00"^^xsd:dateTime as ?requestTime)

  << << ?s1 rdfs:subClassOf <Vegetable> >> seaa:eventId ?eventId1 >> seaa:deletionTime ?deletionTime1 ;
  																	seaa:transactionTime ?transactionTime1 .
  FILTER(?deletionTime1 > ?requestTime)
  FILTER(?transactionTime < ?requestTime1)
  OPTIONAL{
    << << ?s2 rdfs:subClassOf ?s1 >> seaa:eventId ?eventId2 >> seaa:deletionTime ?deletionTime2 .
    << << ?s2 rdfs:subClassOf ?s1 >> seaa:eventId ?eventId22 >> seaa:transactionTime ?transactionTime2 .

    OPTIONAL{
    	<< << ?s3 rdfs:subClassOf ?s2 >> seaa:eventId ?eventId3 >> seaa:deletionTime ?deletionTime3 .
      	<< << ?s3 rdfs:subClassOf ?s2 >> seaa:eventId ?eventId33 >> seaa:transactionTime ?transactionTime3 .
  	}
  }
}
