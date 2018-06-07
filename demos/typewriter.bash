#!/bin/bash
while read -r LINE; do
    echo "${LINE}"
    T=$(( ( RANDOM % 3 )  + 1 ))
    sleep "$T"
done
