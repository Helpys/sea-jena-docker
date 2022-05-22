#!/bin/sh

# Test wether the string contains the pattern
f_contains () {
   echo "Test wether the two strings are equal '$1' = '$2'"
   if [ $1 = $2 ]
   then
     echo "test ok"
   else
     echo "test not ok"
     exit 1
   fi
}

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

f_contains "Green Goblin" $result
