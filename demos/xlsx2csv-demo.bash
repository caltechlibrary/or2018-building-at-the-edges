#!/bin/bash
xlsx2csv -nl -N demo-data.xlsx | while read -r SHEET; do 
    xlsx2csv -o "${SHEET}.csv" demo-data.xlsx "${SHEET}"; 
done
