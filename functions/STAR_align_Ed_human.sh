#!/bin/bash -l

projPath=$1
sample=$2

cd $projPath

STAR --runMode alignReads \
--genomeDir /crex/proj/sllstore2017018/reference/STAR/human/v2.7.1/ensembl/ \
--readFilesIn ${sample}.R1.trimmed1.fastq.gz ${sample}.R2.trimmed1.fastq.gz \
--runThreadN 8 \
--readFilesCommand zcat \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
--outSAMstrandField intronMotif \
--outFileNamePrefix "$sample" \
--outSAMtype BAM SortedByCoordinate

