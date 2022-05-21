#!/bin/sh
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX01 >> .temp
docker exec $(docker ps -q) test/base_test.sh >> .temp
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX02 >> .temp
docker exec $(docker ps -q) test/base_test.sh | grep "test fail" | wc -l >> .temp
echo YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY03 >> .temp
