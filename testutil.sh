#!/bin/sh
docker ps -a

rm -f .temp
docker exec $(docker ps -q) test/turtle_example.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/sea_example.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/rdf_star_example.sh >> .temp
echo "" >> .temp

cat .temp


numberOfFails=$(grep "assertion-fail" .temp | wc -l)
if [ $numberOfFails = 0 ]
then
  echo "all tests OK"
else
  echo "$numberOfFails tests fails"
  exit 1
fi
