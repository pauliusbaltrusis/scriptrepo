#!/bin/bash -l

bamfiles='/Users/paulius.baltrusis/Desktop/VDJ/'

for i in ${bamfiles}/*.bam
do
	picard MarkDuplicates -I $i -O ${i%.bam}.RD.bam \
	-M ${i%.bam}.metrics.txt --REMOVE_DUPLICATES true
done	
