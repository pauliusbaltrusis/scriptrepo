#!/bin/bash -l

str1=$(cat Reverse_amplicon_seq/R_final_file_names.txt)
str2=$(cat Reverse_amplicon_seq/R_final_read_names.txt)

SAVEIFS=$IFS # Save current IFS (Internal Field Separator)  
IFS=$'\n' # Change IFS to newline char

str1=($str1) # split the `str1` string into an array by the same name
str2=($str2)

IFS=$SAVEIFS # Restore original IFS

len=$(ls ERR*.RD.bam | wc -l) # count the number of files in the dir
len=$(($len-1)) # arrays start counting from 0; so adjust the # of files

for i in $(seq 0 $len) # From 0 to 57 (file number) 

do

samtools view ${str1[$i]}.RD.bam | grep ${str2[$i]} | head -n 2 >> all.reverse.reads.txt

done