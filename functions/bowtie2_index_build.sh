#!/bin/bash -l

#SBATCH -A snic2022-22-736
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 16:00:00
#SBATCH -J bowtie_build
#SBATCH -o bowtie2build.log


module load bioinfo-tools
module load bowtie2

Projpath='/home/pauliusb/sllstore2017018/reference/R64-1-1_Cerev_genome_fa'

cd $Projpath
bowtie2-build Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa Scerevisiae
