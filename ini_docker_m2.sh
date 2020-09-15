#!/bin/sh
echo "inicia o meu docker!"
docker run -v /home/rodolfo/dev/:/home/rods/dev/ -v /home/rodolfo/dev/html/:/var/www/html/ -ti m2:1.0
