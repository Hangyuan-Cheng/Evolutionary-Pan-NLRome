#!/bin/bash
#csub -q c01 -n 32 -R "span[hosts=1]" -e y3551.errors.txt bash mul_findpep.sh
source ~/.bashrc
conda activate NLR
for OG in `tail -n+1 rest.txt|cut -f1`;do
  {  
	  presentive=$(awk -v mode=$(awk '{print $2}' <(seqkit fx2tab -n -l ../raw/${OG}.pep.fa) | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}') '$2 == mode {print $1}' <(seqkit fx2tab -n -l ../raw/${OG}.pep.fa)|head -n1)
	  seqkit grep -f <(echo $presentive) ../raw/${OG}.pep.fa > check.pep.fa2
	  bash mul_findpep.sh ${OG}

	  echo "--------${OG}--------"
	  bash calculate_raw_newOG.sh ${OG}
}
done
