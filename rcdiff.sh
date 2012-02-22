#!/bin/bash
for config_file in _*
do
    home_file=$HOME/${config_file/_/.}
    diff -q $config_file $home_file
    different=$?
    [[ $different == 1 ]] && cp $home_file $config_file
done
