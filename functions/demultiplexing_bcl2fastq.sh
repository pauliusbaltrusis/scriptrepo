#!/bin/bash -l
#SBATCH -A naiss2023-22-788
#SBATCH -p devel
#SBATCH -n 15
#SBATCH -t 1:00:00
#SBATCH -J 20230821_bcl2fastq
#SBATCH -o 20230821_bcl2fastq.log

module load bioinfo-tools
module load bcl2fastq

bcl2fastq -R /proj/snic2019-30-56/nobackup/projects/230908_VH00349_150_AACVLCGM5 \
-o /home/pauliusb/sllstore2017018/paulius/2023_08_21_SEYAP \
--sample-sheet /home/pauliusb/seq_sample_sheets/2023_08_21_seq_sheet_template_2.csv \
--no-lane-splitting --barcode-mismatches 1
