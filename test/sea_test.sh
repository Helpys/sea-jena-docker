#!/bin/dash
. ./test/assert.sh

fallback_command () {
  echo "FAILLED"
  exit 1
}

# echo "xxxx Green Goblin XXXXXX" | assert_contains "Green[[:space:]]Goblin"
xa="Green"
echo "xxxx Green Goblin XXXXXX" | grep -c $xa || fallback_command

# || fallback_command
# echo "END"
