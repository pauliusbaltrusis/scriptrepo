#!/bin/bash -l

## You should specify either --local or --end-to-end!!!

base=$1
projPath=$2
ref=$3

cd ${projPath}

bowtie2 --local -x ${ref} \
-1 ${projPath}/${base}_R1_001.fastq.gz -2 ${projPath}/${base}_R2_001.fastq.gz \
-S ${projPath}/BOWTIE_local/${base}_mapped_file.sam &> ${projPath}/BOWTIE_local/${base}_bowtie2.txt
