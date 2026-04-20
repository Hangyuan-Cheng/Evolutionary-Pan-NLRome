#!/bin/bash
source ~/.bashrc
conda activate NLR
for i in `tail -n+1 title.txt|cut -f1`;do
  {
    hmmsearch --domtblout ${i}.domain.loca.tbl -E 1e-10 PF00931_NBARC.hmm ${i}.NLRome.fa > hmmer_temp.out

    awk '{print $1 "\t" $3 "\t" $18 "\t" $19}' ${i}.domain.loca.tbl|sort -k1,1 -u > ${i}.NLR.isoform.list

    #get longest cds ID
    awk 'BEGIN { OFS="\t" } { temp=$1; sub(/\.[^.]*$/, "", temp); $3=temp; print }' ${i}.NLR.isoform.list| sort -k3,3 -k2,2nr | awk '!seen[$3]++ {print $1}' > longestproID.txt

    grep -f longestproID.txt ${i}.NLR.isoform.list  > ${i}.longest_pro.hmmsearch.txt
    
    seqkit grep -f <(less "${i}".longest_pro.hmmsearch.txt |cut -f1) ${i}.NLRome.fa > ${i}.NLRome2.fa
    
    #get NBARC domain and rename
    seqkit subseq --bed <(less "${i}".longest_pro.hmmsearch.txt |cut -f1,3,4) -u 1 -d 0 -o ${i}.NBARC.fa ${i}.NLRome2.fa
    sed -i 's/\:\._us\:1//g' ${i}.NBARC.fa
    sed -i 's/-/_/g' ${i}.NBARC.fa

    echo "NewBee! ${i} NLRome have been listed"
    rm ${i}.domain.loca.tbl ${i}.NLR.isoform.list ${i}.longest_pro.hmmsearch.txt
  }
done
rm hmmer_temp.out
rm longestproID.txt
