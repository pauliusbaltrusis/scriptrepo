#!/bin/bash -l

## You should specify either --local or --end-to-end!!!

sample=$1
projPath=$2
i=$3
ref=$4

cd ${projPath}
module load bioinfo-tools
module load bowtie2/2.3.5.1
module load iGenomes
module load samtools/1.10

bowtie2 --end-to-end -x ${ref} \
-1 ${projPath}/${i}/${sample}_R1_001.fastq.gz -2 ${projPath}/${i}/${sample}_R2_001.fastq.gz | samtools view -b -h -o ${projPath}/BOWTIE_endtoend/${sample}.bam &> ${projPath}/BOWTIE_endtoend/${sample}_bowtie2.txt
