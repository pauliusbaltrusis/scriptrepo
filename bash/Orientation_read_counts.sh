#!/bin/bash
dir=$1
out=$2
f='Forward'
r='Reverse'

cd "$dir"
for x in *_RG_NODUP.bam
do
echo "Doing $x"
samtools view -F 16 $x | cut -f 1,3,4,6 | sed "s/$/\tID:Z:$f/" > "${out}/${x%_RG_NODUP.bam}.Forward.txt"
samtools view -f 16 $x | cut -f 1,3,4,6 | sed "s/$/\tID:Z:$r/" > "${out}/${x%_RG_NODUP.bam}.Reverse.txt"
done