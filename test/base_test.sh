#!/bin/sh
echo "----------"
echo "test file: ($0)"
bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
echo "----------"
bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}"



# echo HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld
# docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
# ruby -v
# ls -lat
# ./test/sea_test.sh "aaa" "aaa" "string test words"
# ./test/sea_test.sh "1" "1" "string test numbers"
# ./test/sea_test.sh 1 1 "number test"
