#!/bin/sh
test/base_test.sh

# rm -f .temp
#
# echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX01 >> .temp
# docker exec $(docker ps -q) test/base_test.sh >> .temp
# docker exec $(docker ps -q) test/fuseki_test.sh >> .temp
# echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX02 >> .temp
#
# cat .temp
#
# echo "ruby testutil.sh"
# docker exec $(docker ps -q) ruby -v
#
# echo "x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x"
# numberOfFails=$(grep "test fail" .temp | wc -l)
# if [ $numberOfFails = 0 ]
# then
#   echo "Test OK"
# else
#   echo "$numberOfFails tests fails"
#   exit 1
# fi
