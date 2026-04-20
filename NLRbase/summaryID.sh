#echo -e "Accession\tNLR-ID" > ID.summary.txt

if test -e `pwd`/allID.list; then
                rm allID.list
                echo "File allID.list exists! Now delete!"
        fi
for accession in `tail -n+1 accession.list|cut -f1`;do
{	
	#number statistic
	#number=$(less ${accession}.NLR-ID.tsv|cut -f1,13|sort -k1,1 -k2,2|uniq|awk -F "\t" '$2 != "-"  {print}'|egrep -v 'superfamily|plant|Topless|Transport inhibitor response 1 domain'|awk -F'\t' 'BEGIN { OFS=FS } $2 == "Protein kinase domain" { a[++n] = $0; next } { b[++m] = $0 } END { for (i=1; i<=n; ++i) print a[i]; for (j=1; j<=m; ++j) print b[j] }'|awk -F'\t' '$2 == "Protein kinase domain" {print; skip[$1]=1; next} !($1 in skip)'|wc -l)
	#echo -e "${accession}\t${number}" >> ID.summary.txt

	#distrubution statistic
	less ${accession}.NLR-ID.tsv|cut -f1,13|sort -k1,1 -k2,2|uniq|awk -F "\t" '$2 != "-"  {print}'|egrep -v 'superfamily|plant|Topless|Transport inhibitor response 1 domain'|awk -F'\t' 'BEGIN { OFS=FS } $2 == "Protein kinase domain" { a[++n] = $0; next } { b[++m] = $0 } END { for (i=1; i<=n; ++i) print a[i]; for (j=1; j<=m; ++j) print b[j] }'|awk -F'\t' '$2 == "Protein kinase domain" {print; skip[$1]=1; next} !($1 in skip)' >> allID.list
	less ${accession}.NLR-ID.tsv|cut -f1,13,7,8|sort -k1,1 -k4,4|uniq|awk -F "\t" '$4 != "-"  {print}'|egrep -v 'superfamily|plant|Topless|Transport inhibitor response 1 domain'|awk -F'\t' 'BEGIN { OFS=FS } $4 == "Protein kinase domain" { a[++n] = $0; next } { b[++m] = $0 } END { for (i=1; i<=n; ++i) print a[i]; for (j=1; j<=m; ++j) print b[j] }'|awk -F'\t' '$4 == "Protein kinase domain" {print; skip[$1]=1; next} !($1 in skip)' >> allID_domain.list
}
done
