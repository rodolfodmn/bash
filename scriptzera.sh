#!/bin/bash

##### DEV by: Vagner 20/07/2018 ###############################################################################################
###############################################################################################################################
#### WARNING #### WARNING ###### WARNING - ANTES DE EXECUTAR O SCRIPT É NECESSÁRIO REALIZAR ALTERAÇÕES                   ######
################################ 1. PASSAR COMO PRIMEIRO PARAMETRO O NOME DA LOJA.                                       ######
################################ 2. PASSAR COMO SEGUNDO PARAMETRO O NOME DO BANCO QUE DEVE SER BAIXO.                    ######
################################ 3. CASO NECESSÁRIO ALTERAR OS CAMINHOS DOS DIRETÓRIOS PARA OS DEVIDOS ARQUIVOS E LOJAS. ######
################################ 4. CRIAR PASTA __Logs DENTRO DA PASTA LOJAS.											 ######
###############################################################################################################################


banco_da_loja=$2

set -e

echo "Iniciando processo..."
echo "Acessando pasta Lojas"

# Acesso ao diretório das Lojas 
cd /var/www/Lojas

echo "**************************************************************" >> /var/www/Lojas/__Logs/logs.txt
echo "Log criado em: `date` by: Vagner" >> /var/www/Lojas/__Logs/logs.txt

echo "Clonando loja..."

# git clone da loja 
git clone git@bitbucket.org:bis2bis/$1.git

echo "Loja Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Criando variaveis..."

#nome do banco que sera setado no arquivo local.xml e também o nome do banco que será criado....como padrão é o nome da loja SEM separação com traço (-) e sem espaços.
db=`ls -c |head -1 | sed -e 's/-//ig'`

#nome da loja que será usado no base url
nome_loja=`ls -c |head -1`

echo "Variaveis Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Movendo arquivos htaccess e local..."

#move arquivo htaccess para pasta da loja 
cp /home/dev010/Downloads/htaccess /var/www/Lojas/"${nome_loja}"/.htaccess

echo "Arquivo Htaccess Ok!" >> /var/www/Lojas/__Logs/logs.txt

#move arquivo local para a pasta etc da loja
cp /home/dev010/Downloads/local.xml /var/www/Lojas/"${nome_loja}"/app/etc/

echo "Arquivo Local Ok!" >> /var/www/Lojas/__Logs/logs.txt

#renomeia arquivo a linha dbname do arquivo local.xml para o nome da loja 
perl -i -pe "s!<dbname>.*?</dbname>!<dbname><\!\[CDATA[${db}]]></dbname>!s" /var/www/Lojas/"${nome_loja}"/app/etc/local.xml

echo "dbname Modificado Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Criando banco..."

#cria o banco o nome da loja sem traços e sem espaços
mysql -u root -p123 -e "create database ${db}"

echo "Banco Criado Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Acessando pasta da loja..."

#acessa pasta da loja
cd /var/www/Lojas/"${nome_loja}"

echo "Baixando banco..."

#baixa a banco da loja se estiver disponivel na url
wget -c -r -nd -A "${banco_da_loja}" http://tools.bis2bis.com.br/dumps/databases/

echo "Acesso URL dbs Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Populando banco..."

#popula o db criado com o dados do db baixado
pv "${banco_da_loja}" | mysql -u root -p123 "${db}"

echo "Banco Populado Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Mudando senha admin..."

#altera a senha do admin para admin
mysql -u root -p123 "${db}" -e "UPDATE admin_user SET password = MD5('admin') WHERE username LIKE 'admin'"

echo "Alteração do admin Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Mudando BASE URL..."

#modifica arquivos base url
mysql -u root -p123 "${db}" -e "UPDATE core_config_data core, (SELECT config_id, core_config_data.value FROM core_config_data WHERE (path LIKE '%web/unsecure/base_url%' OR path LIKE '%web/secure/base_url%')) dados SET core.value = (CONCAT('http://localhost/', '${nome_loja}/')) WHERE core.config_id = dados.config_id"

echo "Alteração BASE URL Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Criando pasta var e setando permissões"

#cria pasta var
mkdir /var/www/Lojas/"${nome_loja}"/var

echo "Pasta Var Ok!" >> /var/www/Lojas/__Logs/logs.txt

#seta permissões na pasta var e media
chmod 777 var -R
chmod 777 media -R

echo "Permissões Ok!" >> /var/www/Lojas/__Logs/logs.txt
echo "Fim"
echo "Script executado com sucesso! Loja ${nome_loja} pronta para uso." >> /var/www/Lojas/__Logs/logs.txt

firefox localhost/"${nome_loja}"

firefox localhost/"${nome_loja}"/admin



###############################################################################################################################
###############################################################################################################################
###############################################################################################################################



################## COMANDOS UTEIS ###################################

# transfere o commit da loja para o modulo;
# git --git-dir=/var/www/Lojas/NOMEDALOJA/.git format-patch -k -1 --stdout HASHDOCOMIT | git am -3 -k --ignore-whitespace 