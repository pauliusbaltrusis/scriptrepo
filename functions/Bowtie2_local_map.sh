#!/bin/bash -l

## You should specify either --local or --end-to-end!!!

sample=$1
projPath=$2
i=$3
ref=$4

cd ${projPath}

bowtie2 --local -x ${ref} \
-1 ${projPath}/${i}/${sample}_R1_001.fastq.gz -2 ${projPath}/${i}/${sample}_R2_001.fastq.gz \
-S ${projPath}/BOWTIE_local/${sample}_mapped_file.sam &> ${projPath}/BOWTIE_local/${sample}_bowtie2.txt
