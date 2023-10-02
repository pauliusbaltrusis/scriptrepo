#! /bin/bash

# Read 1 sequences to trim also: -g CATCACGAT -g CTTAGGCAT -g CCGATGTAT
# Read 2 sequences to trim also:


wd='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/5P_Santo_adaptation_seqdata/raw_files'

cd "$wd"
# Start with both reads
 for i in *_R1_001.fastq.gz
 do
 cutadapt -m 1 -j 0 -g AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -G AGATCGGAAGAGCGTCGTGTAGGGAAAG -a GGGGG -A GGGGG -n 2 \
 -o ${i%_R1_001.fastq.gz}.R1.trimmed2.fastq.gz -p ${i%_R1_001.fastq.gz}.R2.trimmed2.fastq.gz $i ${i%_R1_001.fastq.gz}_R2_001.fastq.gz
 done

 # Do fastqc
 
mv *.trimmed2.fastq.gz Trimmed/

cd "${wd}/Trimmed"
fastqc *.gz