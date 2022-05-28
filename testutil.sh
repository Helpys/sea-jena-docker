#!/bin/sh
docker ps -a

rm -f .temp
docker exec $(docker ps -q) test/turtle_example.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/rdf_star_example.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/sea_example.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/temporal_example.sh >> .temp
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
