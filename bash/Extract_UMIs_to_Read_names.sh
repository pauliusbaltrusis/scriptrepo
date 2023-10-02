#! /bin/bash

# Extract UMIs (first 6 nts) in read 1 and replace fastq headers with them

# Provide the wd
Projpath=$1

cd "$Projpath"

for i in *.fastq.gz

do

less $i | sed -n '2~4p' | cut -c 1-6 > UMIs.txt

while IFS= read -r pattern 

do 

sed "s/1:N:0.*/1:N:0:$pattern/g" $i > ${i%.fastq.gz}.UMInames.fastq

done < UMIs.txt

#Optional
rm UMIs.txt

done

if [-d Reads_with_UMInames]; then
	mv *.UMInames.fastq Reads_with_UMInames
else
	mkdir Reads_with_UMInames
	mv *.UMInames.fastq Reads_with_UMInames
fi