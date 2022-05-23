#!/bin/sh

# Test wether the string contains the pattern
# parameters: string, pattern
f_contains () {
   echo "Test wether the string contains the pattern string:'$1' pattern:'$2'"
   echo $1 | grep -c $2
   occurences=$(echo $1 | grep -c $2)
   if [ $occurences -gt 0 ]
   then
     echo "test ok (occurences:$occurences)"
   else
     echo "test not ok\nthe string '$1' does not contain the pattern:'$2'"
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

f_contains $result "Green Goblin"
