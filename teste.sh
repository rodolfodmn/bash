#!/bin/bash
echo 'teste!'
echo $1
if [ -z "$1" ]; then
    echo "String is empty"
elif [ -n "$1" ]; then
    if [ "$1" == 'b' ]; then
        echo "basic"
    else
        echo "nao e basic"
    fi
fi