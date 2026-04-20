#search ID domain and cut the boundary
grep "NAC domain" allID_complete_domain.list > NAD_domain.list
seqkit subseq --bed <(less NAD_domain.list |cut -f1,3,4) -u 1 -d 0 -o NAD_domain.pep.fa allOG.manual.pep.fa
sed -i 's/\:\._us\:1//g' NAD_domain.pep.fa
sed -i 's/-/_/g' NAD_domain.pep.fa
cd-hit -i NAD_domain.pep.fa -o NAD_domain_95_95.domain.pep.fa -c 0.95 -aL 0.95 -aS 0.95
blastp -db blast_database/all -query NAD_domain_95_95.domain.pep.fa -outfmt 6 -evalue 1e-10 -out NAD_domain.blastp.txt

#make all protein database and blast ID domain
makeblastdb -in all.pep.fa -dbtype prot -parse_seqids -input_type fasta -out all
awk '$3 >= 95 {print}' Zinc.blastp.txt|cut -f2|sort|unNAD_domain
