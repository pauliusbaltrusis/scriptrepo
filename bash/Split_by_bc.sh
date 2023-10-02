#!/bin/bash

# split files by a barcode

sample='M3_S3_mapped_file_RG_HNODUP.bam'

Proj_path='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Split_RG_named'

abarcodes=("GTCTTAACGCCACAGAGATAGCGCAG" "TACTTAGAGCCACAGAGATAGCGCAG" "TATGTAACGCCACAGAGATAGCGCAG" "GCAGTATTGCCACAGAGATAGCGCAG" "CATAGAGAGCCACAGAGATAGCGCAG" "TACAGCGAGCCACAGAGATAGCGCAG" "GAATACAAGCCACAGAGATAGCGCAG" "GTTAGTATGCCACAGAGATAGCGCAG" "TTGACAATGCCACAGAGATAGCGCAG" "TGTAGAACGCCACAGAGATAGCGCAG")

cbarcodes=("CCATTGATACGGGTGCTCATCGTTCC" "TACTAACTACGGGTGCTCATCGTTCC" "TTACTAGGACGGGTGCTCATCGTTCC" "CACTATCTACGGGTGCTCATCGTTCC" "ATACTTGCACGGGTGCTCATCGTTCC" "TTACTACTACGGGTGCTCATCGTTCC" "TCAACAAGACGGGTGCTCATCGTTCC" "GTGTAACTACGGGTGCTCATCGTTCC" "CTTAGAAGACGGGTGCTCATCGTTCC" "GAGCAAATACGGGTGCTCATCGTTCC")

bbarcode=("GGTCAAACGGCGCCTGGA")

abarcode_names=("a1" "a2" "a3" "a4" "a5" "a6" "a7" "a8" "a9" "a10")

cbarcode_names=("c1" "c2" "c3" "c4" "c5" "c6" "c7" "c8" "c9" "c10")

MS3='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Mapped_unsplit/M3_S3_mapped_file_RG_NODUP.bam'

MS4='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Adrianas_LoopSeq/Mapped_unsplit/M4_S4_mapped_file_RG_NODUP.bam'

cd $Proj_path

for x in *_NODUP.bam
do	
	samtools view -h $x | awk '/^@/ || /'${bbarcode}'/' | samtools view -bSh > ${x%_mapped_file_RG_NODUP.bam}_B.bam
	for ((i = 0; i < ${#abarcodes[@]}; i++)) 
	do 
	samtools view -h $x | awk '/^@/ || /'${abarcodes[i]}'/' | samtools view -bSh > ${x%_mapped_file_RG_NODUP.bam}_${abarcode_names[i]}.bam
	samtools view -h $x | awk '/^@/ || /'${cbarcodes[i]}'/' | samtools view -bSh > ${x%_mapped_file_RG_NODUP.bam}_${cbarcode_names[i]}.bam
	done
done


#Merge all files (a1, a2, a3 ...) with B barcode and retain only in perfect pairs reads

for g in M*_[a-c][0-9]*.bam #M*_S*_[a-c][0-9]*_RG.bam
do
	if [[ "$g" == M3_S3_* ]]; then # determine if the input file is M3 or M4
		file_input=$MS3
	else
		file_input=$MS4
	fi
	
	samtools merge ${g%.bam}_outB.temp.bam $g $file_input 
	samtools view -h -f 2 ${g%.bam}_outB.temp.bam | samtools view -bSh > ${g%.bam}_outB.bam # need to compress it to .bam again after viewing
	samtools index ${g%.bam}_outB.bam # errors for some reason
	rm ${g%.bam}_outB.temp.bam
done

# rename @RG (read group) header in these split files OPTIONAL

for i in M*_[a-c][0-9]_outB*.bam
do
samtools addreplacerg -r ID:${i%.bam} --input-fmt BAM --output-fmt BAM -o ${i%.bam}_outB_RG.bam $i
samtools index  ${i%.bam}_outB_RG.bam ${i%.bam}_RG.bam.bai
done

## Create read-name files

