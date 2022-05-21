#!/bin/sh


#
# "simply select test"
#
echo "load standard turtle example"
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl

sparql="@base <http://example.org/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rel: <http://www.perceive.net/schemas/relationship/> .

SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}"

a=$(docker exec $(docker ps -q) bin/s-query \
--service http://localhost:3030/example/query \
$sparql\
 | grep -o "Green Goblin")\
 && ./test/sea_test.sh "simply select test" "Green Goblin" $a

#
# "rdf & sparql star select test"
#
echo "load rdf star turtle example"
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/rdf_star_example.ttl
parql="PREFIX : <http://www.example.org/>

SELECT ?claimer WHERE {
   << :employee38 ?property ?value >> :accordingTo ?claimer
}"

a=$(docker exec $(docker ps -q) bin/s-query \
--service http://localhost:3030/example/query \
$sparql\
 | grep -o "Green Goblin")\
 && ./test/sea_test.sh "sparql star select test" "Green Goblin" $a
