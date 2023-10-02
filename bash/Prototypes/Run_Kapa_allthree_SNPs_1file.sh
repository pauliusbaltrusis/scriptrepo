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
script_loc='/Users/paulius.baltrusis/OneDrive - Karolinska Institutet/scripts/bash'
bam_loc=/Users/paulius.baltrusis/OneDrive\ -\ Karolinska\ Institutet/Kapa_BoundaryHAP_22/Kapa_S2_A_SNPs
#
for i in "$bam_loc"/chr*.snps.parameters.txt
do
echo "$i"
cd "$bam_loc"
for j in {1..7}
do
	echo "Creating var$j"
	varname="var${j}"
	var_value=$(awk "FNR==$j" "$i")
	declare "${varname}=${var_value}"
done

bash "$script_loc"/Kapa_snp_extract.sh \
"$var1" \
$var2 \
$var3 \
$var4 \
$var5 \
$var6 \
$var7
done