#!/bin/sh
echo "---------------------- sea test --------------------------"

if [ "$#" -ne 2 ]
then
  echo "usage: sea_test expected actual"
  exit 1
fi

if [ $1 = $2 ]
then
  echo "test ok"
else
  echo "test fail: expected \"$1\" got \"$2\""
fi
