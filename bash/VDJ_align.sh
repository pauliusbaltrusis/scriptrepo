#!/bin/bash -l

index='/Users/paulius.baltrusis/Desktop/VDJ/BWA_index_sg02/SG02.fa'
file_loc='/Users/paulius.baltrusis/Downloads'

for i in ${file_loc}/*_1.filt.fastq.gz
do
base=$(basename $i _1.filt.fastq.gz)
echo $base 
bwa mem -t 4 $index ${file_loc}/${base}_1.filt.fastq.gz \
${file_loc}/${base}_2.filt.fastq.gz > ${base}.sam
echo mapping for $base done...starting conversion to .bam
samtools view -b ${base}.sam | samtools sort -o ${base}.bam
rm ${base}.sam
done
