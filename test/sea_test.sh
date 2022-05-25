#!/bin/sh
echo "include $0"
ls -la /bin/sh

assert_contains () {
  # echo "-----------------  assert_contains  -----------------"
  # echo "\$_:$_"
  # echo "\$#:$#"
  # echo "\$0:$0"
  # echo "\$1:$1"
  # echo "-----------------------------------------------------"
  while read line
  do
    occurence=$(echo $line | grep -c $1 | bc)
    occurences=$(( $occurences + $occurence ))
    total="${total}$line\n"
  done

  if [ $occurences -gt 0 ]
  then
    echo "assert_contains ok, found $occurences occurence(s)"
  else
    echo "assert_contains assertion-fail, pattern '$1' not found"
    echo $total
  fi
}

#
# usage:
# assert_contains stream_input string_to_match
# Example:
# cat ./test/turtle_example.ttl | assert_contains "www"
#
