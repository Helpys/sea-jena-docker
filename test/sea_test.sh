#!/bin/sh
echo "---------------------- sea test --------------------------"

if [ "$#" -ne 3 ]
then
  echo "error, test fail: it need 3 arguments. you have given $#."
  echo "usage: sea_test actual expected title"
  exit 1
fi

if [ "$1" = "$2" ]
then
  echo "test '$3' ok"
else
  echo "test fail '$3': expected \"$2\" got \"$1\""
fi
