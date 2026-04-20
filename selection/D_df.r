args <- commandArgs(T)
setwd("/share/org/YZWL/yzwl_chenghy/evo_NLRome/OGtree/MSA")
library(PopGenome)
library(readr)
library(stringr)
align_seq <- read.big.fasta(filename = args[1],window=200000,
                            populations = FALSE,outgroup = FALSE,  
                            SNP.DATA = FALSE,parallized = FALSE,  
                            FAST = FALSE,big.data = TRUE)
##set population
pop1<-scan(args[2],list(""));
pop2<-scan(args[3],list(""));
pop3<-scan(args[4],list(""));

GENOME.class <- set.populations(align_seq,list(pop1[[1]],pop2[[1]],pop3[[1]]))
GENOME.class <- set.outgroup(GENOME.class,1)
GENOME.class <- introgression.stats(GENOME.class,
        subsites=FALSE,
        do.D=TRUE,
        do.df=TRUE,
        keep.site.info=TRUE,
	block.size=TRUE,
        do.RNDmin=FALSE,
        l.smooth=FALSE)


GENOME.class@D
#GENOME.class@D.z
#GENOME.class@D.pval
GENOME.class@f
GENOME.class@df
#GENOME.class@df.z
#GENOME.class@df.pval

#print(GENOME.class.split@nuc.F_ST.pairwise)

output_vectorD <- capture.output(GENOME.class@D)
output_vectorf <- capture.output(GENOME.class@f)
output_vectordf <- capture.output(GENOME.class@df)

file_path <- "df.result.txt"

a <- output_vectorD[2]
b <- output_vectorf[2]
c <- output_vectordf[2]

D <- sub(".*?\\s", "", a)
f <- sub(".*?\\s", "", b)
df <- sub(".*?\\s", "", c)


out=data.frame(number=args[1],D=D,f=f,df=df)
write.table(out, file = file_path, quote=F, append = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)
