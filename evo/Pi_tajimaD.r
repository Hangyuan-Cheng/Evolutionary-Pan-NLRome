args <- commandArgs(T)
setwd("/share/org/YZWL/yzwl_chenghy/evo_NLRome/checkOG/selection/MSA")
library(PopGenome)
library(readr)
library(stringr)
align_seq <- read.big.fasta(filename = args[1],window=200000,
                            populations = FALSE,outgroup = FALSE,  
                            SNP.DATA = FALSE,parallized = FALSE,  
                            FAST = FALSE,big.data = TRUE)

align_seq <- F_ST.stats(align_seq)
align_seq <- neutrality.stats(align_seq) 
output_vector <- capture.output(align_seq@Pi/align_seq@n.valid.sites,align_seq@Tajima.D)

file_path <- "Pi_tajimaD.result.txt"

a <- output_vector[2]
b <- output_vector[4]
Pi <- sub(".*?\\s", "", a)
TajimaD <- sub(".*?\\s", "", b)

out=data.frame(number=args[1],pi=Pi,TajimaD=TajimaD)
write.table(out, file = file_path, quote=F, append = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)

