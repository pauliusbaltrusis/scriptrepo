#!/bin/bash -l


dir=$1
name=$2

cd "$dir"

for i in *.gz
do
multiqc -n $name .
done

