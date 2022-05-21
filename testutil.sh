#!/bin/sh
rm -f .temp

echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX01 >> .temp
docker exec $(docker ps -q) test/base_test.sh >> .temp
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX02 >> .temp

cat .temp


echo "x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x"
numberOfFails=$(grep "test fail" .temp | wc -l)
echo "number of fails = $numberOfFails"
