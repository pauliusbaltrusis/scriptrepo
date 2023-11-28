#!/bin/bash

#file input
file=$1

# number of fasta entries in a file
entryno=$(grep -c ">" $file)

# collect only sequences 1 per line
grep -v ">" $file > ${file}.temp.txt

base=$(basename $file .txt)

# for every line in the entry
for ((i=1 i<=$entryno i++))
do
seq=$(awk ' NR=='$i' {print}' '${file}.temp.txt') # first sequence on line 1
A=$(grep -o '[Aa]' <<< $seq | grep -c '[Aa]') #calculate A, T, C, G and Ns
T=$(grep -o '[Tt]' <<< $seq | grep -c '[Tt]')
C=$(grep -o '[Cc]' <<< $seq | grep -c '[Cc]')
G=$(grep -o '[Gg]' <<< $seq | grep -c '[Gg]')
N=$(grep -o '[Nn]' <<< $seq | grep -c '[Nn]')

	if (( N>=1)); then  # If there's Ns then terminate script
		echo 'There is ${N}s in your sequences N = ${N}' 
		exit
	fi

tm=$(awk 'BEGIN {x= '$A'; y= '$T'; z= '$G'; n = '$C'; print ((x+y)*2+(z+n)*4)}') #calculate tm of each sequence 

# tm=$(echo "scale=2; ($A+$T)*2+($G+$C)*4" | bc)

echo $tm >> ${base}.TMs.txt #paste Tm 1 per line
echo '' >> ${base}.TMs.txt #enter empty line as a separator

rm ${file}.temp.txt #remove temporary file with seq names

done