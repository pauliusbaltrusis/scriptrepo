#!/bin/bash

#module load bioinfo-tools samtools

for i in Kapa_BoundaryHAP_22/*_RG_NODUP.bam
do

##Mapped reads on every target:
	for f in HCS_target/*.bed
	do

	samtools view -c -F 4 -b $i -L $f >> ${i%.bam}

	done


done
