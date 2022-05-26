#!/bin/dash
echo "include $0"
ls -la /bin/dash

assert_contains () {
  echo "=================  assert_contains  ================="
  echo "\$_:$_"
  echo "\$#:$#"
  echo "\$0:$0"
  echo "\$1:$1"
  echo "\$2:$2"
  echo "====================================================="
  occurence=$((0))
  lines=$((0))

  while read line
  do
    occurence=$(echo $line | grep -c $1)
    occurences=$(( $occurences + $occurence ))
    lines=$(( $lines + 1 ))
    total="${total}$line\n"
  done

echo "occurences:'$occurences'"

  if [ $occurences -gt 0 ]
  then
    echo "assert_contains ok, found $occurences occurence(s) of the pattern '$1'"
  else
    echo "assert_contains assertion-fail, pattern '$1' not found"
    echo "red '$lines' line(s)"
    echo $total
    exit 1
  fi
}

#
# usage:
# assert_contains stream_input string_to_match
# Example:
# cat ./test/turtle_example.ttl | assert_contains "www"
#
