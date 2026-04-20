#!/bin/bash
#csub -q c01 -n 2 -R "span[hosts=1]" -e y3551.errors.txt bash calculate_raw_newOG.sh OG1
source ~/.bashrc
conda activate NLR
OG=$1
if [ -f "name.txt" ]; then
    rm name.txt
fi

for i in `tail -n+1 277.txt|cut -f1`;do
  {   
	  raw=$(grep ${i} ../raw/${OG}.cds.fa|wc -l )
	  now=$(grep ${i} ../finalOG/${OG}.manual.cds.fa|wc -l )
	  if [ $raw -gt $now ]; then
		seqkit fx2tab -n -l ../raw/${OG}.cds.fa|grep ${i}
		seqkit fx2tab -n ../raw/${OG}.cds.fa|grep ${i} >> name.txt
    	fi
	# awk '{ $2 = '${i}_${OG}_NLR_extra'; print }' OFS='\t' temprename > rename.list
}
done

