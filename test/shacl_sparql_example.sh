#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# validate Bar class
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/dataset/data default test/shacl_sparql_example.ttl

result=$(curl -XPOST --data-binary @test/shacl_sparql_example.shacl.ttl  \
     --header 'Content-type: text/turtle' \
     'http://localhost:3030/dataset/shacl?graph=default')

echo "XXX-------------------------------------------------------------------------------"
echo $result
echo "XXX-------------------------------------------------------------------------------"
echo $result | assert_contains "false"
echo $result | assert_contains "\"Spain\"@en"

# curl -XPOST --data-binary @test/shacl_sparql_example.shacl.ttl --header 'Content-type: text/turtle' 'http://localhost:3030/dataset/shacl?graph=default'
# curl -X POST -d "query=select ?s where { ?s ?p ?o . }" 'http://localhost:3030/dataset/query?graph=default'
# curl -X PUT -d "query=delete ?s ?p ?o where { ?s ?p ?o . }" 'http://localhost:3030/dataset/update?graph=default'
# curl -X GET -d "query=delete where { << ?s ?p ?o >> ?a ?b . }" 'http://localhost:3030/dataset/update?graph=default'
# curl -X GET -d "query=delete where { << << ?s ?p ?o >> ?a ?b >> ?aa ?bb . }" 'http://localhost:3030/dataset/update?graph=default'
# docker container exec -it $(docker ps -a -q); /bin/bash
