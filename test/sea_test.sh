#!/bin/dash
. ./test/assert.sh

fallback_command () {
  echo "FAILLED"
  exit 1
}

# echo "xxxx Green Goblin XXXXXX" | assert_contains "Green[[:space:]]Goblin"
occurence=echo "xxxx Green Goblin XXXXXX" | grep -c "Green Goblin" || fallback_command
echo "END"
