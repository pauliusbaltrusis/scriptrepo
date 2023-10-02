#!/bin/bash

#loc1=$1
#file1=$2

fna_loc='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/rRNA_genes'

for i in "${fna_loc}"/*.fna
do
filename=$(basename -- "$i")
bash rRNA_oligo_gen.sh \
'/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/rRNA_genes' \
"$filename"
done