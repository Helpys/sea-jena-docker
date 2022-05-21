#!/bin/sh

echo "load standard turtle example"
docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl

a=$(docker exec $(docker ps -q) bin/s-query \
--service http://localhost:3030/example/query \
'SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}' | grep -o "Green Goblin")\
 && ./test/sea_test.sh "Green Goblin" $a
