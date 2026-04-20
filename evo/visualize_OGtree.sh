source ~/.bashrc
conda activate r-ggtree
for i in `tail -n+1 known.list|cut -f1`;do
  {
	  egrep 'NH001|NH002|NH005|NH013|NH016|NH030|NH033|NH034|NH038|NH039|NH048|NH060|NH061|NH062|NH072|NH089|NH096|NH117|NH119|NH125|NH131|NH135|NH137|NH141|NH142|NH145|NH146|NH238|NH240|NH242|Os02428|DHX2|Kosh|KY131|Lemont|LJ|NamRoo|ZH11|B4013|D4038|H4078|P4140|Q4148|R4160|X4209|Y4211|Y4214|H4077|AGIS|GP117|GP505|GP523|GP680|HP436|NIP|02428_' <(seqkit fx2tab -n ${i}_outgroup_known.255asian.manual.cds.fa) > JAP.txt

	egrep 'NH123|NH129|NH243|NH246|NH247|NH203|NH206|NH182|NH183|NH184|NH101|NH091|NH053|NH051|NH070|Os9311|9311_|CN1|D62|DG|FH838|FS32|G46_OG|OsG46|OsG630|G630_|OsG8|G8_OG|II32|IR64|J4155|R498|R527|S548|TM_|_TM|Tumba|WSSM|Y3551|Y58S|YX1|E4047|H4080|N4127|N4130|Q4145|Q4146|S4165|X4205|E4049|534M|Gla4|GP100|GP119|GP58|GP622' <(seqkit fx2tab -n ${i}_outgroup_known.255asian.manual.cds.fa) > IND.txt

	egrep 'W0103|W0107|W0147|W0179|W0590|W0627|W0630|W0632|W0639|W1080|W1084|W1107|W1117|W1142|W1547|W1619|W1666|W1677|W1679|W1719|W1723|W1726|W1731|W1732|W1735|W1737|W1750|W1787|W1825|W1839|W1865|W1970|W2053|W2064|W2305|W2319|W2332|W0108|W0143|W0145|W0157|W0164|W0166|W0169|W0171|W0180|W0234|W0594|W0596|W0600|W0634|W1093|W1126|W1214|W1236|W1292|W1550|W1552|W1553|W1556|W1557|W1736|W1742|W1810|W1859|W1880|W1890|W1895|W1919|W1976|W2022|W2108|W2197|W2267|W2283|W2308|W2310|W2311|W2318|W2320|W2321|W3007|W3054|W3090|W0133|W0135|W0136|W0137|W0149|W0573|W1536|W1559|W1668|W1718|W1725|W1748|W1777|W1783|W1809|W1943|W2005|W2036|W2051|W2066|W2099|W2275|W3000|W3009|W3012|W3029|W3033|W3035|W3037|W3038|W3040|W3046|W3047|W3051|W3052|W3055|W3063|W3066|W3071|W3074|W3082|W3086|W3088|W3092|W3096' <( seqkit fx2tab -n ${i}_outgroup_known.255asian.manual.cds.fa) > rufi.txt

	egrep 'Basmati1|C4029|D4039|G4068|GP524|GP543|GP635|H4072|HP519|J4081|K4092|L4102|L4106|N22|R4152|R4157|S4166|T4172|T4176|X4207|X4208' <( seqkit fx2tab -n ${i}_outgroup_known.255asian.manual.cds.fa) > other.txt
	
	egrep 'Bph14|Pi37|Pish|Pit|ADR1|Pid|Pib|BPH1_like|Piz-t|Pid4|Pi42|RGA4|Pik-2|BRW1|Pi-ta|RGA5|Pik-1|Piz-t|Pi2|Pigm-R6|Pi9|Pigm-R8|Pik-2|Pi7-2|Pikh-2|Piks-2|Pikp-2|Pikm2-TS|Pik-1|Pikm1-TS|Pikp-1|Piks-1|Pikh-1|Pi7-1|Pijx|Pi5-2|Pi56|Pi5-1|PiPR1|Pi63' <( seqkit fx2tab -n ${i}_outgroup_known.255asian.manual.cds.fa)|awk '{print $1}' > known.txt
	awk 'BEGIN {OFS="\t"} {print $1, "O. sativa japonica"}' JAP.txt > group_file2.txt
	awk 'BEGIN {OFS="\t"} {print $1, "O. sativa indica"}' IND.txt >> group_file2.txt
	awk 'BEGIN {OFS="\t"} {print $1, "Other"}' other.txt >> group_file2.txt
	awk 'BEGIN {OFS="\t"} {print $1, "O. rufipogon"}' rufi.txt >> group_file2.txt
	awk 'BEGIN {OFS="\t"} {print $1, "Known"}' known.txt >> group_file2.txt
	
	 presentive=$(seqkit fx2tab -n -l ../../checkOG/finalOG/presentiveOG.pep.fa |grep _${i}_ |cut -f2)

seqkit grep -f <(egrep -v -i 'NH277|NH278|NH279|NH280|NH281|NH282|NH283|NH284|NH285|NH286|NH265|NH266|NH267|NH268|NH269|NH270|NH271|NH272|NH273|NH274|NH275|CG14' <( seqkit fx2tab -n <( awk '{print $1}' ${i}_outgroup_known.255asian.manual.cds.fa))) <(awk '{print $1}' ${i}_outgroup_known.255asian.manual.cds.fa)|seqkit translate --trim|seqkit fx2tab -n -l > temp.list

awk -v presentive="$presentive" -F' ' '$2 > (presentive / 2)' temp.list | cut -f1 > complete
awk -v presentive="$presentive" -F' ' '$2 < (presentive / 2)' temp.list | cut -f1 > truncated


awk 'BEGIN {OFS="\t"} {print $1, "Complete"}' complete > group_file3.txt
if [ -s truncated ]; then
	awk 'BEGIN {OFS="\t"} {print $1, "Truncated"}' truncated >> group_file3.txt
fi

echo -e "Sample\tStatus\tGroup" > group_file.txt
awk 'BEGIN {FS=OFS="\t"}  NR==FNR {a[$1]=$2; next}  $1 in a {print $1, a[$1], $2}  ' group_file3.txt group_file2.txt >> group_file.txt
echo -e "Outgroup_${i}\tComplete\tOutgroup" >> group_file.txt
rm group_file2.txt group_file3.txt

Rscript ggtree.r ${i}_O.treefile
}
done
rm JAP.txt IND.txt rufi.txt other.txt temp.list complete truncated
