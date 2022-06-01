#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# validate Bar class
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
bin/s-put http://localhost:3030/dataset/data default test/shacl_example.ttl

result=$(curl -XPOST --data-binary @test/shacl_example.shacl.ttl  \
     --header 'Content-type: text/turtle' \
     'http://localhost:3030/dataset/shacl?graph=default')

echo "XXX-------------------------------------------------------------------------------"
echo $result
echo "XXX-------------------------------------------------------------------------------"
echo $result | assert_contains "ValidationReport"
