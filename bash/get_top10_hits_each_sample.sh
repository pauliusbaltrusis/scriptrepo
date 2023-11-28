#! /bin/bash

file=$1 #give file name

length=$(less $1 | grep -v '^#' | head -n 1 | awk 'NR==1 {print NF}') #last column in the table

for i in $(seq 7 $length); do
title=$(awk -v col="$i" 'NR==2 {print $col}' "$file" | cut -d'/' -f3) #file name
cat $file | awk '{print $0}'| sort -k${i},${i}nr | head -n 11 > ${title}.txt
echo column $i done
done