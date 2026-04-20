#!/bin/bash
#csub -q c01 -n 2 -R "span[hosts=1]" -e y3551.errors.txt bash mul_findpep.sh OG1
source ~/.bashrc
conda activate NLR
OG=$1
rm -r temp
mkdir temp
for i in `tail -n+1 277.txt|cut -f1`;do
  {   
miniprot -It 30 --gff-only miniprot_index/${i}.mpi check.pep.fa2 --outs=0.95 --outc=0.95 -G 15k -L 100 -m 2 -P "${i}_${OG}_NLR"  > temp/check.${i}.gff3
gffread temp/check.${i}.gff3 -g genome/${i}.genome.fa -x temp/check.${i}.cds.fa
sed -i 's/00000/0/g' temp/check.${i}.cds.fa

    #if file exist and not empty
    if [ -s "temp/check.${i}.cds.fa" ]; then
	#Start with "ATG"
	ATG=$(awk '{if(p){if(/^ATG/){print h}else{print ""};p=0}if(/^>/){h=$0;p=1}}END{if(p)print ""}' temp/check.${i}.cds.fa|grep -v '^$'|sed 's/^>//')
	if [ -z "$ATG" ]; then
    		rm temp/check.${i}.*
	fi

	#average identity > 95%
	average_identity=$(awk '$3=="mRNA"' temp/check.${i}.gff3|grep -o 'Identity=[0-9.]*;'| sed 's/Identity=\([0-9.]*\);/\1/'|awk 'NR > 0 {sum += $1; count++} END {print sum / count}')
	if (( $(echo "$average_identity < 0.95" | bc -l) )); then
    		rm temp/check.${i}.*
	fi
fi
}
done

cat temp/*.cds.fa > ../finalOG/${OG}.manual.cds.fa
