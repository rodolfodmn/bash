#!/bin/bash
if [ -z "$2" ]; then
    echo 'por favor passe os parametros :('    
elif [ -n "$1" ]; then
    if [ "$1" == 'i' ]; then
        echo 'instalando api Gtd :)'
        cp -r ~/dev/modulos/modulo-gtd/*  .
        git add .
        git commit -m "Instalacao - Gtd - #$2"
    elif [ "$1" == 'a' ]; then
        echo 'install gitlab store script :)'
        cp -r ~/dev/modulos/modulo-gtd/*  .
        git add .
        git commit -m "Atualizacao - Gtd - #$2"
    else
        echo "seu parametro deve estar incorreto :("
    fi
fi