echo -e "Accession\tComplete\tTruncated" > truncated.summary.txt
for accession in `tail -n+1 accession.list|cut -f1`;do
{
	complete=$(grep -f <(seqkit fx2tab -n ${accession}.allOG.manual.pep.fa) OGtruncated.allNLRome.txt|grep Complete|wc -l)
	truncated=$(grep -f <(seqkit fx2tab -n ${accession}.allOG.manual.pep.fa) OGtruncated.allNLRome.txt|grep Truncated|wc -l)
	echo -e "${accession}\t${complete}\t${truncated}" >> truncated.summary.txt
}
done
