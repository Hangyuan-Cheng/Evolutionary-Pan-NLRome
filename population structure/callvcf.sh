#!/bin/bash
#csub -q c01 -n 64 -R "span[hosts=1]" -e y3551.errors.txt bash callvcf.sh
source ~/.bashrc
conda activate snp
for i in `tail -n+1 145.txt|cut -f1`;do
  {  
minimap2 -ax asm5 --cs -r2k -t 64 MSU.fa ../checkOG/repair/genome/${i}.genome.fa > bam/${i}_MSU.sam
samtools sort -@ 64 -O bam -o bam/${i}_MSU.bam bam/${i}_MSU.sam
samtools index bam/${i}_MSU.bam
rm bam/${i}_MSU.sam
#bam2vcf
bcftools mpileup -a AD,DP -I --threads 64 -Ou -f MSU.fa bam/${i}_MSU.bam | bcftools call --threads 64 -mv -Oz -o vcf/${i}_MSU.vcf.gz
tabix vcf/${i}_MSU.vcf.gz
}
done

bcftools merge -m all --threads 64 -Oz -o 255.species.vcf.gz vcf/*.vcf.gz
tabix 255.species.vcf.gz
