echo -e "accession\tCNL\tCN\tNL\tN"
for accession in `tail -n+1 accession.list|cut -f1`;do
{
	grep NB-ARC ${accession}.interproscan.tsv.tsv|cut -f1|uniq > tempNBARC.txt	
	#Initialize the variable to 0
	CNL=0
	CN=0
	NL=0
	N=0
	
	if test -e `pwd`/${accession}.CNL.list; then
    		rm ${accession}.CNL.list
		rm ${accession}.CN.list
		rm ${accession}.NL.list
		rm ${accession}.N.list
    		echo "File ${accession}.list exists! Now delete!"
	fi

	for NLR in `tail -n+1 tempNBARC.txt|cut -f1`;do
	{	
		a=$(grep ${NLR} ${accession}.interproscan.tsv.tsv|grep Leucine-rich|wc -l)
		b=$(grep ${NLR} ${accession}.interproscan.tsv.tsv|egrep "coil|Coil|Rx N-terminal"|wc -l)
		
		if [ $a -gt 0 ] && [ $b -gt 0 ]; then
    			CNL=$((CNL + 1))
			echo ${NLR} >> ${accession}.CNL.list
		elif [ $a -gt 0 ] && [ $b -eq 0 ]; then
    			CN=$((CN + 1))
			echo ${NLR} >> ${accession}.CN.list
		elif [ $a -eq 0 ] && [ $b -gt 0 ]; then
    			NL=$((NL + 1))
			echo ${NLR} >> ${accession}.NL.list
		elif [ $a -eq 0 ] && [ $b -eq 0 ]; then
    			N=$((N + 1))
			echo ${NLR} >> ${accession}.N.list
		fi
	}
	done
	echo -e "${accession}\t${CNL}\t${CN}\t${NL}\t${N}"
	rm tempNBARC.txt
}
done
