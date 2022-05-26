#!/bin/dash
. ./test/assert.sh


docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/rdf_star_example.ttl
