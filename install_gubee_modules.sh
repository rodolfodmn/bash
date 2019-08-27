#!/bin/bash
if [ -z "$1" ]; then
    echo 'por favor passe uma referencia :('    
elif [ -n "$1" ]; then
    echo 'instalando api bis2bis :)'
    cp -r ~/dev/modulos/modulo-api-bis2bis/src/*  .
    git add .
    git commit -m "Instalacao Gubee: Api Bis2Bis #$1"
    
    echo 'instalando Gtd :)'
    php ~/dev/php_bash/moduleInstall.php gtd $1
    git add .
    git commit -m "Instalacao Gubee: Gtd #$1"

    echo 'instalando nota fiscal :)'
    php ~/dev/php_bash/moduleInstall.php nota-fiscal $1
    git add .
    git commit -m "Instalacao Gubee: Nota Fiscal #$1"

    echo 'instalando marketplace shipping/payment :)'
    # Marketplace Shipping
    php ~/dev/php_bash/moduleInstall.php gubee/marketplace-shipping $1    
    git add .
    git commit -m "Instalacao Gubee:  Marketplace Shipping #$1"
    
    # Marketplace Payment        
    php ~/dev/php_bash/moduleInstall.php gubee/marketplace-payment $1    
    git add .
    git commit -m "Instalacao Gubee: Marketplace Payment - #$1"

    echo 'instalando gubee :)'
    php ~/dev/php_bash/moduleInstall.php gubee/gubee $1    
    git add .
    git commit -m "Instalacao Gubee: Gubee #$1"

    echo 'Lembre que voce precisa atulaizar os modulos:'  
    echo '* Api bis2bis'  
    echo '* Gtd'  
    echo '* Nota fiscal'  
    echo '* Gubee'
    echo 'E ativar o Pagamento Marketplace - Configurações Gerais'  
    echo 'Tks ;)'
fi
