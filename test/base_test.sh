#!/bin/sh
echo "---------------------------------"
echo "test file: ($0)"
echo "---------------------------------"
bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
echo "----------"
result=$(bin/s-query --service http://localhost:3030/example/query "SELECT * {<http://example.org/#green-goblin> <http://xmlns.com/foaf/0.1/name> ?o}")
echo "result s-query='$result'"
echo "----------"
result=$(echo $result | grep -o "Green Goblin")
echo "result grep='$result'"
echo "----------"
if [ $result = "Green Goblin" ]
then
  echo "test ok"
else
  echo "test not ok"
  exit 1
fi
