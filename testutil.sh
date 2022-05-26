#!/bin/sh
docker ps -a

rm -f .temp
docker exec $(docker ps -q) test/base_test.sh >> .temp
echo "" >> .temp
docker exec $(docker ps -q) test/fuseki_test.sh >> .temp
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
