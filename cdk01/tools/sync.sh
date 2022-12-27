#!/bin/sh

while [ true ]
do
    rsync -a env node01:
    rsync -a node01:env/cdktf.out ./
    sleep 2
done