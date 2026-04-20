args <- commandArgs(T)
setwd("/share/org/YZWL/yzwl_chenghy/evo_NLRome/checkOG/selection/MSA")
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
GENOME.class.split<-F_ST.stats(align_seq, list(pop1[[1]],pop2[[1]]),mode="nucleotide");
#print(GENOME.class.split@nuc.F_ST.pairwise)

output_vector <- capture.output(GENOME.class.split@nuc.F_ST.pairwise)
file_path <- "Fst.result.txt"

a <- output_vector[2]
Fst <- sub(".*?\\s", "", a)
out=data.frame(number=args[1],Fst=Fst)
write.table(out, file = file_path, quote=F, append = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)
