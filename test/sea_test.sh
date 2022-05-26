#!/bin/dash
. ./test/assert.sh


echo "xxxx Green Goblin XXXXXX" | assert_contains "Green[[:space:]]Goblin"
