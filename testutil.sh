#!/bin/sh
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX01
docker exec $(docker ps -q) test/base_test.sh
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX02
docker exec $(docker ps -q) test/base_test.sh | grep "test fail" | wc -l
echo YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY03
