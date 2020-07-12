#!/bin/bash

if [ -z "$1" ]; then
    echo 'install store script :)'
    php ~/dev/php_bash/storeInstall.php
elif [ -n "$1" ]; then
    if [ "$1" == 'b' ]; then
        echo 'install basic store script :)'
        php ~/dev/php_bash/storeBasicInstall.php
    elif [ "$1" == 'l' ]; then
        echo 'install gitlab store script :)'
        php ~/dev/php_bash/storeLabInstall.php
    elif [ "$1" == 'dev' ]; then
        echo 'install dev, isso mesmo rodolfo coisas novas  ;)'
        php ~/dev/php_bash/storeInstall_dev.php
    elif [ "$1" == 'ng' ]; then
        echo 'install sem abrir no navegador  ;)'
        php ~/dev/php_bash/storeInstall.php 1
    else
        echo "seu parametro nao deve estar incorreto :("
    fi
fi
