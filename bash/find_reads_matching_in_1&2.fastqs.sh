#! /bin/bash


read1_names=$(awk '/^@/' read1.fastq)

read2_names=$(awk '/^@/' read2.fastq)

for (i=1; i<$(wc -l $read1_names | cut -d ' ' -f  1); i++))
do
	seq=$(awk -v line=$i 'NR==line')
	if grep -q "$seq" read2_names; then
		grep -A 3 "$seq" read1.txt > filtered.1.fastq
		grep -A 3 "$seq" read2.txt > filtered.2.fastq
	fi
done


# a much more direct solution:

grep -Ff read2_names.txt read_names1.txt > common_names.txt

grep -Ff common_names.txt read1.fastq > read1_filt.fastq
grep -Ff common_names.txt read2.fastq > read2_filt.fastq
