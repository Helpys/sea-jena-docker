#!/bin/sh
echo HelloWorld
ruby -v
ls -lat
echo HELLO-WORLD
echo "test fail"
ls -lat test
ls -lat bin
ls -lat configuration
test -f && echo "ok" || echo "test fail"
