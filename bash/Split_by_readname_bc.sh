#!/bin/bash

## create read_name files

projPath='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Split_RG_named'

MS3='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Mapped_unsplit/M3_S3_mapped_file_RG_NODUP.bam'

MS4='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Mapped_unsplit/M4_S4_mapped_file_RG_NODUP.bam'

cd "$projPath"

for i in *.bam # loop through all bam files a1, a2, a3.bam etc.
do
	samtools view $i | awk '{print $1}' > ${i%.bam}.readnames.txt #generate all the read names from split files
	
	line_count=$(wc -l ${i%.bam}.readnames.txt | awk '{print $1}') # number of lines for a file containing read names
	
	samtools view -H $i > header.txt # save the header and fuse later

	if [[ "$i" == M3_S3_* ]]; then # determine if the input file is M3 or M4
		file_input=$MS3
	else
		file_input=$MS4
	fi

	for ((y = 1; y <= $line_count; y++)) # loop through all read names
	do
	x=$(awk -v n=$y 'NR==n' ${i%.bam}.readnames.txt) #this is the pattern for line x

	samtools view "$file_input" | awk '/'$x'/' >> ${i%.bam}.withB.temp #append reads to a new temp file
	
	done
	cat header.txt ${i%.bam}.withB.temp | samtools view -bSh > ${i%.bam}.withB.sam
	#rm header.txt ${i%.bam}.withB.temp
done
