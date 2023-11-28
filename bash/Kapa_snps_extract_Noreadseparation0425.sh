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
mkdir chr${chr}_bothOrients0425_outputs
#
cd "$path"
for x in *_RG_NODUP.bam
do
echo "Starting on $x"
#0 Add file name, remove unnecessary Picard columns
filename=$(basename -- "$x") #Get file name without the path extension
samtools view $x -f 2 -h | cut -f 1,2,3,4,5,6,7,8,9,10,11 |
 sed "s/$/\tID:Z:${filename%.bam}/" | samtools view -bSh > ${x%.bam}.1.bam
samtools index ${x%.bam}.1.bam
#1 Small .bam file with tag combo
tag_combo=$(echo $filename | cut -d "_" -f 2,6) ## of course, the columns cut will depend on file name. Consistency!
samtools view ${x%.bam}.1.bam "chr$chr:$SNP1-$SNP2" -h | sed "s/$/\tID:Z:$tag_combo/" | samtools view -bSh > ${x%.bam}.2.bam
samtools index ${x%.bam}.2.bam

##2 Distinguish between + and - reads
#samtools view -F 16 ${x%.bam}.2.bam -h | sed "s/$/\tID:Z:$f/" | samtools view -bSh > ${x%.bam}.2.Forward.bam
#samtools view -f 16 ${x%.bam}.2.bam -h | sed "s/$/\tID:Z:$r/" | samtools view -bSh > ${x%.bam}.2.Reverse.bam

##2.5 Re-filter reads twice (into overlapping SNP1 and overlapping SNP2 = reads overlapping both are removed)
bedtools intersect -a ${x%.bam}.2.bam -b $SNP2bed -f 1 > ${x%.bam}.3.SNP2.bam 
bedtools intersect -a ${x%.bam}.2.bam -b $SNP1bed -f 1 > ${x%.bam}.3.SNP1.bam
samtools merge -f ${x%.bam}.SNPs1and2_marked.bam ${x%.bam}.3.SNP2.bam ${x%.bam}.3.SNP1.bam
#2.6 Remove entire (fraction=1.0) reads between the two SNPS that do not overlap at least 1 SNP (Keep only reads fully within the SNP panel region)
bedtools subtract -f 1 -a ${x%.bam}.SNPs1and2_marked.bam -b $Between_region  > ${x%.bam}.SNPs1and2_marked.2.bam
samtools index ${x%.bam}.SNPs1and2_marked.bam
samtools index ${x%.bam}.SNPs1and2_marked.2.bam
#3 Making a text file
samtools view ${x%.bam}.SNPs1and2_marked.2.bam > ${x%.bam}.bothOrients.txt
sed 's/ID:Z://g' ${x%.bam}.bothOrients.txt > ${x%.bam}.bothOrients.output.txt
#3.5 Make a new dir and move the files there
mv ${x%.bam}.SNPs1and2_marked.bam ${x%.bam}.SNPs1and2_marked.bam.bai \
${x%.bam}.SNPs1and2_marked.2.bam ${x%.bam}.SNPs1and2_marked.2.bam.bai ${x%.bam}.bothOrients.output.txt chr${chr}_bothOrients0425_outputs/
#4 Delete intermediate files
rm ${x%.bam}.1.bam ${x%.bam}.1.bam.bai ${x%.bam}.2.bam ${x%.bam}.2.bam.bai ${x%.bam}.3.SNP1.bam ${x%.bam}.3.SNP2.bam
echo "Done on $x"
done