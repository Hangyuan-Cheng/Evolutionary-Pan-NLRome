source ~/.bashrc
conda activate snp
for K in {2..10}; do
  admixture --cv 255.species.doublefiltered.vcf.bed $K -j64 | tee log_K${K}.out
done
