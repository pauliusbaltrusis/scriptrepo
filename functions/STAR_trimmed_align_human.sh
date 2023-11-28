#!/bin/bash -l

projPath=$1
sample=$2

# --readFilesCommand zcat \

cd $projPath

STAR --runMode alignReads \
--genomeDir /crex/proj/sllstore2017018/reference/STAR/human/v2.7.1/ensembl/ \
--readFilesIn ${sample}_R1_trimmed20_8UMIremoved.fastq \
--runThreadN 8 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--outFilterType BySJout \
--outFileNamePrefix ${sample}20_8_R1 \
--outSAMtype BAM SortedByCoordinate


STAR --runMode alignReads \
--genomeDir /crex/proj/sllstore2017018/reference/STAR/human/v2.7.1/ensembl/ \
--readFilesIn ${sample}_R2_trimmed20_8UMIremoved.fastq \
--runThreadN 8 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--outFilterType BySJout \
--outFileNamePrefix ${sample}20_8_R2 \
--outSAMtype BAM SortedByCoordinate
