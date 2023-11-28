
#!/bin/bash -l

db=$1
projPath=$2
i=$3
sample=$4


cd ${projPath}

#Already indexed!
##bwa index -p hg38p14 /home/pauliusb/hg38p14_ref

bwa mem -t 16 ${db} \
${projPath}/${i}/${sample}_R1_001.fastq.gz ${projPath}/${i}/${sample}_R2_001.fastq.gz |
samtools view -b -f 2 | samtools sort -o ${projPath}/BWA/${sample}.bam

java -jar $PICARD_HOME/picard.jar MarkDuplicates -I ${projPath}/BWA/${sample}.bam  -O ${projPath}/BWA/${sample}_NODUP_BWA.bam  -M ${sample}_marked_dup_metrics.txt --REMOVE_DUPLICATES true

samtools index ${projPath}/BWA/${sample}_NODUP_BWA.bam ${projPath}/BWA/${sample}_NODUP_BWA.bam.bai

