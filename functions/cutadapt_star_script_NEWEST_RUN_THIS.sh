#!/bin/bash -l

#SBATCH -A naiss2023-22-788

#SBATCH -p core

#SBATCH -n 4

#SBATCH -t 16:00:00

#SBATCH -J {date}_cutadapt_star

#SBATCH -o {date}_cutadapt_star



module load bioinfo-tools

module load cutadapt

module load star/2.7.1a

module load FastQC

projPath=$1

cd "$projPath"

### fastQC 1 raw 

fastqc *

if [ -d QC_raw ]; then
	mv *html *zip QC_raw
else
	mkdir QC_raw
	mv *html *zip QC_raw
fi

###
### 0.Trim

for i in *R2_001.fastq.gz # remove 3' adapters from read 2
do
	cutadapt -m 20 -j 0 -n 2 -a AGATCGGAAGAGC -a GGGGGG -o ${i%_001.fastq.gz}_trimmed.fastq $i
done

for i in *R1_001.fastq.gz
do
	cutadapt -m 20 -j 0 -n 2 -a AGATCGGAAGAGC -a GGGGGG -o ${i%_001.fastq.gz}_trimmed.fastq $i
done

if [ -d Trimmed_reads ]; then
	mv *.fastq Trimmed_reads
else
	mkdir Trimmed_reads
	mv *.fastq Trimmed_reads
fi

cd Trimmed_reads/

### fastQC 2 trimmed
fastqc *

if [ -d QC_trimmed ]; then
	mv *html *zip QC_trimmed
else
	mkdir QC_trimmed
	mv *html *zip QC_trimmed
fi

###


### 1.STAR

for j in *R1_trimmed.fastq
do
STAR --runMode alignReads \
--genomeDir /crex/proj/sllstore2017018/reference/STAR/human/v2.7.1/ensembl/ \
--readFilesIn $j \
--runThreadN 8 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--outFilterType BySJout \
--outFileNamePrefix ${j%_trimmed.fastq} \
--outSAMtype BAM SortedByCoordinate
done

for j in *R2_trimmed.fastq
do
STAR --runMode alignReads \
--genomeDir /crex/proj/sllstore2017018/reference/STAR/human/v2.7.1/ensembl/ \
--readFilesIn $j \
--runThreadN 8 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--outFilterType BySJout \
--outFileNamePrefix ${j%_trimmed.fastq} \
--outSAMtype BAM SortedByCoordinate
done

if [ -d STAR_stuff ]; then
	mv *.bam *.out *.tab STAR_stuff
else
	mkdir STAR_stuff
	mv *.bam *.out *.tab STAR_stuff
fi
###


