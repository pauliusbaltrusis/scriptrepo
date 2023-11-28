#!/bin/bash -l

## You should specify either --local or --end-to-end!!!

## Yeast

base=$1
projPath=$2
ref=$3

cd ${projPath}

bowtie2 --end-to-end --very-sensitive -x ${ref} \
-1 ${projPath}/${base}_R1.fastq -2 ${projPath}/${base}_R2.fastq \
-S ${projPath}/BOWTIE_local/${base}_mapped_file.sam &> ${projPath}/BOWTIE_local/${base}_bowtie2.txt
