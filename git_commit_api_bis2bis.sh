#!/bin/bash
if [ -z "$2" ]; then
    echo 'por favor passe os parametros :('    
elif [ -n "$1" ]; then
    if [ "$1" == 'i' ]; then
        echo 'instalando api bis2bis :)'
        cp -r ~/dev/modulos/modulo-api-bis2bis/src/*  .
        git add .
        git commit -m "Instalacao - Api Bis2Bis - #$2"
    elif [ "$1" == 'a' ]; then
        echo 'install gitlab store script :)'
        cp -r ~/dev/modulos/modulo-api-bis2bis/src/*  .
        git add .
        git commit -m "Atualizacao - Api Bis2Bis - #$2"
    else
        echo "seu parametro deve estar incorreto :("
    fi
fi