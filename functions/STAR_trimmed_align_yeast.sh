#!/bin/bash -l

projPath=$1
sample=$2

cd $projPath

STAR --runMode alignReads \
--genomeDir /proj/snic2019-30-56/lilit/genome/SC/star_index \
--readFilesIn ${sample}.R1.trimmed3.fastq.gz \
--readFilesCommand zcat \
--alignIntronMax 2500 \
--runThreadN 8 \
--outFilterType BySJout \
--outFileNamePrefix ${sample}_R1 \
--outSAMtype BAM SortedByCoordinate 

STAR --runMode alignReads \
--genomeDir /proj/snic2019-30-56/lilit/genome/SC/star_index \
--readFilesIn ${sample}.R2.trimmed3.fastq.gz \
--readFilesCommand zcat \
--alignIntronMax 2500 \
--runThreadN 8 \
--outFilterType BySJout \
--outFileNamePrefix ${sample}_R2 \
--outSAMtype BAM SortedByCoordinate
