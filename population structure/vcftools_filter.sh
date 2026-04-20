source ~/.bashrc
conda activate snp
vcftools --gzvcf 255.species.vcf.gz --minQ 30 --recode --out 255.species.filtered.vcf
plink --vcf 255.species.filtered.vcf.recode.vcf --maf 0.05 --geno 0.75 --indep-pairwise 50 5 0.2 --make-bed --recode vcf --threads 64  --out 255.species.doublefiltered.vcf --double-id
