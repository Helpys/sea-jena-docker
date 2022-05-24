#!/bin/sh

f_contains() {
  echo "-----------------  f_contains  ----------------------"
  echo "\$_:$_"
  echo "\$#:$#"
  echo "\$0:$0"
  echo "\$1:$1"
  echo "-----------------------------------------------------"
  while read line
  do
    occurences+=$(echo $line | grep -c $1)
    echo "-----------------------------------------------------"
    total="${total}$line\n"
  done
  echo "-------------------$occurences----------------------------"
echo $total
}
cat ./test/turtle_example.ttl | f_contains "Goblin"
