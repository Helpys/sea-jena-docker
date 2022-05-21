#!/bin/sh
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX01 >> .temp
docker exec $(docker ps -q) test/base_test.sh >> .temp
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX02 >> .temp

cat .temp
echo "x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x"
grep "test fail" .temp | wc -l >> .temp
