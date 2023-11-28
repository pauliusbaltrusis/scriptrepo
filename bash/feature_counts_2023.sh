#! /bin/bash
 
$ProjPath="/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 5.rRNA_5Pseq_Homo/5P_Hong_adaptation_v7_FFPE+HF"
cd $ProjPath

list=$(ls | awk '/.bam/ {print $1}')
for i in *gtf
do
featurecounts -a "$i" -O -o ${i%gtf}.counts.txt -M -f $list
done
