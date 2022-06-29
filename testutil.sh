#!/bin/sh
docker ps -a

echo "**************************"
echo "DIGITAL_OCEAN_IP_ADDRESS=$DIGITAL_OCEAN_IP_ADDRESS"
echo "**************************"

rm -f .temp
docker exec sea_fuseki_container test/turtle_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/rdf_star_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/sea_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/temporal_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/language_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/vegi_temporal_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/shacl_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/shacl_sparql_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/curl_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/sparql_temporal_example.sh >> .temp
echo "" >> .temp
docker exec sea_fuseki_container test/countries_example.sh >> .temp
echo "" >> .temp

cat .temp


numberOfFails=$(grep "assertion-fail" .temp | wc -l)
if [ $numberOfFails = 0 ]
then
  echo "term 'assertion-fail' not found. All tests OK"
else
  echo "$numberOfFails \e[0;31mtests fails\e[0m"
  exit 1
fi

numberOfFails=$(grep "failed" .temp | wc -l)
if [ $numberOfFails = 0 ]
then
  echo "term 'failed' not found. All tests OK"
else
  echo "$numberOfFails \e[0;31mterm 'failed' found. Not Ok\e[0m"
  exit 1
fi

numberOfFails=$(grep "Error" .temp | wc -l)
if [ $numberOfFails = 0 ]
then
  echo "term 'Error' not found. All tests OK"
else
  echo "$numberOfFails \e[0;31mterm 'Error' found. Not Ok\e[0m"
  exit 1
fi
