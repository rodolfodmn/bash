#!/bin/bash
echo 'iniciando servidor...'
sudo service apache2 restart
sudo service mysql restart
sudo service ssh  restart
echo 'servidor iniciado :)'
