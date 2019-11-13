#!/bin/bash
echo 'limpando cache do vim, .swo e .swp'
find ./ -name '*.swo' -delete
find ./ -name '*.swn' -delete
find ./ -name '*.swp' -delete

