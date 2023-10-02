#!bin/bash/
loc1=$1
file1=$2

# move
cd "$loc1"

# Insert an entire file with 1 fasta entry
d1=$(awk '/^>/ {next} { printf $0 } END { printf "\n" }' $file1) ## remove headers starting with ">" and print current line ending at the end on the line
name=$(cat $file1 | grep '^>' | sed "s/>//" | cut -d ' ' -f 2)


# Dummy string
#d1="ACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTGACTG"

n1=${#d1}

start=0 #start pos of sequence 
len=35 #oligo length
by=5 #overlap amount between oligos
step=$((len-by)) # step size 

empty_array=() #auxilary
 
for ((i=$len; i<=$n1; i+=$step)) #start at $len, not at (0)! 
do
	echo ">$start-$i" >> "${name}.txt" #print fa header 
	echo "${d1:start:len}" >> "${name}.txt" # print 1st sequence 0 to len and so on 
	start=$((i-by)) #modify start and repeat

done

