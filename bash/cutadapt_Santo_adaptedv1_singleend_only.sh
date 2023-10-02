#! /bin/bash

# Read 1 sequences to trim also: -g CATCACGAT -g CTTAGGCAT -g CCGATGTAT
# Read 2 sequences to trim also:


wd='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/5P_Santo_adaptation_seqdata/raw_files'

cd "$wd"
# Start with Read 1
 for i in *_R1_001.fastq.gz
 do
 cutadapt -m 1 -g AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -a GGGGG -n 2 -o ${i%_R1_001.fastq.gz}.R1.trimmed1.fastq.gz -j 0 $i
 done
 
# Carry on to Read 2
 for i in *_R2_001.fastq.gz
 do
 cutadapt -m 1 -g AGATCGGAAGAGCGTCGTGTAGGGAAAG -a GGGGG -n 2 -o ${i%_R2_001.fastq.gz}.R2.trimmed1.fastq.gz -j 0 $i
 done

 # Do fastqc
 
mv *.trimmed1.fastq.gz Trimmed/

cd "${wd}/Trimmed"
fastqc *.gz