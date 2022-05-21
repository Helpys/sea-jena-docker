#!/bin/sh
echo "---------------------- sea test --------------------------"

if [ "$#" -ne 3 ]
then
  echo "error: it need 3 arguments. you have given $#"
  echo "\nusage: sea_test title expected actual"
  exit 1
fi

if [ "$2" = "$3" ]
then
  echo "test '$1' ok"
else
  echo "test fail '$1': expected \"$2\" got \"$3\""
fi
