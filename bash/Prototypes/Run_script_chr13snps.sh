#!/bin/bash
#Variables needed
#path=$1
#chr=$2
#SNP1=$3 # SNP1 position in the genome
#SNP2=$4 #SNP2 position in the genome 
#SNP1bed=$5 # file name in the same dir
#SNP2bed=$6
#Between_region=$7 

bash ../chr22_SNPs/Kapa_snp_extract.sh \
/Users/paulius.baltrusis/Desktop/Kapa_BoundaryHAP_22/chr13_SNPs \
13 \
32889968 \
32890026 \
Forward_SNP2.bed \
Reverse_SNP1.bed \
subtract_between_region.bed


