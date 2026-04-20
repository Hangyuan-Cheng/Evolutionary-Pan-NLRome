#!/bin/bash
#csub -q fat2 -n 32 -R "span[hosts=1]" -e y3551.errors.txt bash interproscan.sh
source ~/.bashrc
conda activate NLR
#The genome name is stored in the title_txt file. Change the genome name into XXX.genome.fa 
for accession in `tail -n+1 accession.list1|cut -f1`;do
{
	#sed -i '/^>/!s/\.//g' ${accession}.NLRome.pep.fa 
	~/biosoft/interproscan-5.66-98.0/interproscan.sh -i ${accession}.allOG.manual.pep.fa -f tsv -dp -cpu 32 -b ${accession}.interproscan.tsv
	grep -v -E 'coil|Coil|Rx N-terminal|Leucine-rich|Leucine rich repeat|LEUCINE-RICH REPEAT|disease resistance|Disease resistance|P-loop|p-loop|NB-ARC|L domain-like|consensus disorder prediction|Winged helix-like DNA-binding|Apoptotic protease-activating factors|Gene3D|ATPase domain|RNI-like|PROTEIN-RELATED|TRANSLOCASE OF INNER MITOCHONDRIAL|Powdery mildew resistance protein|ATPase|ARM repeat|Ras_like_GTPase' ${accession}.interproscan.tsv.tsv > ${accession}.NLR-ID.tsv
}
done
