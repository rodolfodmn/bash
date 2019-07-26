#!/bin/bash
if [ -z "$2" ]; then
    echo 'por favor passe os parametros :('    
elif [ -n "$1" ]; then
    if [ "$1" == 'i' ]; then
        echo 'instalando marketplace shipping/payment :)'
        # Marketplace Shipping
        cp -r ~/dev/modulos/marketplace-shipping/*  .
        git add .
        git commit -m "Instalacao - Marketplace Shipping - #$2"
        
        # Marketplace Payment        
        cp -r ~/dev/modulos/marketplace-payment/*  .
        git add .
        git commit -m "Instalacao - Marketplace Payment - #$2"
    elif [ "$1" == 'a' ]; then
        echo 'Atualizando marketplace shipping/payment :)'
        # Marketplace Shipping
        cp -r ~/dev/modulos/marketplace-shipping/*  .
        git add .
        git commit -m "Atualizacao - Marketplace Shipping - #$2"
        
        # Marketplace Payment        
        cp -r ~/dev/modulos/marketplace-payment/*  .
        git add .
        git commit -m "Atualizacao - Marketplace Payment - #$2"
    else
        echo "seu parametro deve estar incorreto :("
    fi
fi