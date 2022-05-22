#!/bin/sh
echo "docker container 5 ($0)"
bin/s-put http://localhost:3030/example/data default test/rdf_star_example.ttl

#
# "simply select test"
#
# echo "test file: '$0'"
# echo "load standard turtle example"
#
# echo "docker ps -q"
# docker ps -q
# docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
#
# echo "ruby fuseki_test.sh"
# docker exec $(docker ps -q) ruby -v
# docker exec $(docker ps -q) ls -lat
# sparql="@base <http://example.org/> .
# @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
# @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
# @prefix foaf: <http://xmlns.com/foaf/0.1/> .
# @prefix rel: <http://www.perceive.net/schemas/relationship/> .
#
# SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}"
# echo "exec select"
# temp=$(docker exec $(docker ps -q) bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}")
# echo $temp
# echo "grep"
# echo $temp | grep -o "Green Goblin" | xargs -I % ./test/sea_test.sh % "Green Goblin" "simply select test"
#
# # a=$(docker exec $(docker ps -q) bin/s-query \
# --service http://localhost:3030/example/query \
# 'SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}')
#
# echo "a='$a'"
#
# b=$(grep -o "Green Goblin" $a)
#
#  ./test/sea_test.sh "Green Goblin" $a "load standard turtle example, simply select test"
#
#
# "rdf & sparql star select test"
#
# echo "load rdf star turtle example"
# docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/rdf_star_example.ttl
# sparql="PREFIX : <http://www.example.org/>
#
# SELECT ?claimer WHERE {
#    << :employee38 ?property ?value >> :accordingTo ?claimer
# }"
#
# a=$(docker exec $(docker ps -q) bin/s-query \
# --service http://localhost:3030/example/query \
# $sparql\
#  | grep -o "Green Goblin")
#
#  ./test/sea_test.sh "sparql star select test" "Green Goblin" $a
