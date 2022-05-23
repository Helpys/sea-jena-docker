#!/bin/sh
echo "Hello World"


# Test wether the string contains the pattern
# parameters: string, pattern
f_contains () {
   echo "Test wether the string contains the pattern string:'$1' pattern:'$2'"
   echo $1 | grep -c $2
   occurences=$(echo $1 | grep -c $2)
   if [ $occurences -gt 0 ]
   then
     echo "test ok (occurences:$occurences)"
   else
     echo "test not ok\nthe string '$1' does not contain the pattern:'$2'"
     exit 1
   fi
}

f_match() {
  if [ "$1" == "$2" ]
  then
    echo match
  else
    echo no match
  fi
}


s1="hi2\n\
go2"
s2="hi1\n
go1"

if [ "$s1" == "$s2" ]
then
  echo match
else
  echo no match
fi

f_match $s1 $s2
f_contains $s1 "go"


# echo "---------------------- sea test --------------------------"
#
# if [ "$#" -ne 3 ]
# then
#   echo "error, test fail: it need 3 arguments. you have given $#."
#   echo "usage: sea_test actual expected title"
#   exit 1
# fi
#
# if [ "$1" = "$2" ]
# then
#   echo "test '$3' ok"
# else
#   echo "test fail '$3': expected \"$2\" got \"$1\""
# fi
