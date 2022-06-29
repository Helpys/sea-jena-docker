#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"

#-------------------------------------------------------------------------------------
# find latest Junior
#-------------------------------------------------------------------------------------
echo "-------------------------------------------------------------------------------"
apache_jena_script/s-delete "http://localhost:3030/example/data" "default"
apache_jena_script/s-put http://localhost:3030/example/data default test/countries_data.ttl

result=$(apache_jena_script/s-get http://localhost:3030/example/data default)
echo $result
echo $result | assert_contains "00000000-0000-0000-0020-100000000001"
echo $result | assert_contains "00000000-0000-0000-0020-000000000001"
