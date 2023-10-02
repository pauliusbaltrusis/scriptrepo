#!/bin/bash
# Variables
path=$1
chr=$2
SNP1=$3 # SNP1 position in the genome
SNP2=$4 #SNP2 position in the genome 
SNP2bed=$5 # file name in the same dir
SNP1bed=$6 # file name in the same dir
Between_region=$7 #file with in between region where full reads are to be removed
# optional
f='Forward'
r='Reverse'
#SNP1bed and SNP2bed are custom input files defining the genomic region of forward/reverse reads separately
#Make a final dir for storage of important files
mkdir chr${chr}_outputs_adjustedFandR
#
cd "$path"
for x in *_RG_NODUP.bam
do
echo "Starting on $x"
#0 Add file name, remove unnecessary Picard columns
filename=$(basename -- "$x") #Get file name without the path extension
samtools view $x -h | cut -f 1,2,3,4,5,6,7,8,9,10,11 | #reads are paired (1), in a proper pair (2), exclude unmapped (4)
 sed "s/$/\tID:Z:${filename%.bam}/" | samtools view -bSh > ${x%.bam}.1.bam
samtools index ${x%.bam}.1.bam
#1 Small .bam file with tag combo
tag_combo=$(echo $filename | cut -d "_" -f 2,6) ## of course, the columns cut will depend on file name. Consistency!
samtools view ${x%.bam}.1.bam "chr$chr:$SNP1-$SNP2" -h | sed "s/$/\tID:Z:$tag_combo/" | samtools view -bSh > ${x%.bam}.2.bam
samtools index ${x%.bam}.2.bam
#2 Distinguish between + and - reads
samtools view -F 16 ${x%.bam}.2.bam -h | sed "s/$/\tID:Z:$f/" | samtools view -bSh > ${x%.bam}.2.Forward.bam
samtools view -f 16 ${x%.bam}.2.bam -h | sed "s/$/\tID:Z:$r/" | samtools view -bSh > ${x%.bam}.2.Reverse.bam
#2.5 Re-filter forward and reverse reads to remove uninteresting reads
bedtools intersect -a ${x%.bam}.2.Forward.bam -b $SNP2bed -f 1 > ${x%.bam}.3.Forward.bam 
bedtools intersect -a ${x%.bam}.2.Reverse.bam -b $SNP1bed -f 1 > ${x%.bam}.3.Reverse.bam
samtools merge -f ${x%.bam}.FandR_marked.bam ${x%.bam}.3.Forward.bam ${x%.bam}.3.Reverse.bam
#2.6 Remove entire (fraction=1.0) reads between the two SNPS that do not overlap at least 1 SNP
bedtools subtract -f 1 -a ${x%.bam}.FandR_marked.bam -b $Between_region  > ${x%.bam}.FandR_marked.2.bam
samtools index ${x%.bam}.FandR_marked.bam
samtools index ${x%.bam}.FandR_marked.2.bam
#3 Making a text file
samtools view ${x%.bam}.FandR_marked.2.bam > ${x%.bam}.txt
sed 's/ID:Z://g' ${x%.bam}.txt > ${x%.bam}.output.txt
#3.5 Make a new dir and move the files there
mv ${x%.bam}.FandR_marked.bam ${x%.bam}.FandR_marked.bam.bai \
${x%.bam}.FandR_marked.2.bam ${x%.bam}.FandR_marked.2.bam.bai ${x%.bam}.output.txt chr${chr}_outputs_adjustedFandR/
#4 Delete intermediate files
rm ${x%.bam}.1.bam ${x%.bam}.1.bam.bai ${x%.bam}.2.bam ${x%.bam}.2.bam.bai ${x%.bam}.2.Forward.bam ${x%.bam}.2.Reverse.bam \
${x%.bam}.3.Reverse.bam ${x%.bam}.3.Forward.bam ${x%.bam}.txt
echo "Done on $x"
done