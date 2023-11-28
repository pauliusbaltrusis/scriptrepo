#!/bin/bash
##Variables needed
#path=$1
#chr=$2
#SNP1=$3 # SNP1 position in the genome
#SNP2=$4 #SNP2 position in the genome 
#SNP1bed=$5 # file name in the same dir
#SNP2bed=$6
#Between_region=$7 
#
script_loc='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/scripts/bash'
bam_loc='/Users/paulius.baltrusis/OneDrive-KarolinskaInstitutet/Different projects/Project 2.Kapa_BoundaryHAP_22/Kapa_Boundary_Exp_22_reseq_23/BOWTIE_local'
# For each SNP panel (n=3) create 7 variables and use them later when calling the pipeline
for i in "$bam_loc"/chr*.snps.parameters.txt
do
file_par=$(basename -- "$i")
echo "$i"
cd "$bam_loc"
for j in {1..7}
do
	echo "Creating var$j for $file_par"
	varname="var${j}"
	var_value=$(awk "FNR==$j" "$i")
	declare "${varname}=${var_value}"
done
# Run the pipeline with the 7 assigned variables (var1...var7; found in the .txts)
bash "$script_loc"/Kapa_snp_extract.sh \
"$var1" \
$var2 \
$var3 \
$var4 \
$var5 \
$var6 \
$var7
done
