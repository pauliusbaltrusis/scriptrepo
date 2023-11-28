#!/bin/bash -l

Picardpath=$1
sample=$2
## Depends on where the files are and the format (.bam or .sam)!

samtools view -bh -f 2 ${Picardpath}/${sample}.sam | samtools sort -o ${Picardpath}/${sample}.bam

java -jar $PICARD_HOME/picard.jar MarkDuplicates -I ${Picardpath}/${sample}.bam  -O ${Picardpath}/${sample}_RG_NODUP.bam  -M ${Picardpath}/${sample}_marked_dup_metrics.txt --REMOVE_DUPLICATES true

samtools index ${Picardpath}/${sample}_RG_NODUP.bam ${Picardpath}/${sample}_RG_NODUP.bam.bai
