#!/bin/bash

if [ -z "$1" ]; then
    echo 'install store script :)'
    php ~/dev/php_bash/storeInstall.php
elif [ -n "$1" ]; then
    if [ "$1" == 'b' ]; then
        echo 'install basic store script :)'
        php ~/dev/php_bash/storeBasicInstall.php
    else
        echo "seu parametro nao deve estar incorreto :("
    fi
fi