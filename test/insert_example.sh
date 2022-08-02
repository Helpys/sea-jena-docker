#!/bin/dash
. ./test/assert.sh

echo "-------------------------------------------------------------------------------"
echo "test file: ($0)"
echo "-------------------------------------------------------------------------------"
# apache_jena_script/s-delete "http://localhost:3030/example/data" "default"
# apache_jena_script/s-put http://localhost:3030/example/data default test/language_example.ttl
sparql="BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>

INSERT {
  :example :name :example
}
WHERE {
}"
# result=$(apache_jena_script/s-update --user admin --password alain --service http://localhost:3030/example/update "$sparql")
apache_jena_script/s-update --service http://localhost:3030/dataset/update "$sparql"

# result=$(curl 'http://localhost:3030/example/update/' \
#   -X POST \
#   -H 'content-type: application/graphql' \
#   --data '$sparql')
# echo $result
# | assert_contains "Schmetterling"
