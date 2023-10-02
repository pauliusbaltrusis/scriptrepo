#! /bin/bash

# Read 1 sequences to trim : AGATCGGAAGAGC = P5 (rev compl of rP5_RND)
# Read 2 sequences to trim : AGATCGGAAGAGC = P7 (rev compl of RH + oligodT)

#Trimmed separately, perhaps i should do them together ?

wd='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/5P_Hong_adaptation_v3/raw'

cd "$wd"

for i in *R2_001.fastq.gz # remove 3' adapters from read 2
 do
 cutadapt -m 20 -j 0 -a AGATCGGAAGAGC -o ${i%_001.fastq.gz}_trimmed20.fastq $i
 #cutadapt -u -6,6 -o ${i%_001.fastq.gz}_trimmed20_6UMIremoved.fastq ${i%_001.fastq.gz}_trimmed20.fastq
done

for i in *R1_001.fastq.gz
do
	cutadapt -m 20 -j 0 -a AGATCGGAAGAGC -o ${i%_001.fastq.gz}_trimmed20.fastq $i
	#cutadapt -u -6,6 -o ${i%_001.fastq.gz}_trimmed20_6UMIremoved.fastq ${i%_001.fastq.gz}_trimmed20.fastq
done