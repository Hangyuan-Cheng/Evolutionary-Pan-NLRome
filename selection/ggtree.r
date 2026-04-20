args <- commandArgs(T)
library(ggtree)
setwd("/share/org/YZWL/yzwl_chenghy/evo_NLRome/OGtree/known")
treefile <- args[1]
tree = read.tree(treefile)

group_file <- read.table("group_file.txt",header = T,row.names = 1,sep = "\t")
groupInfo <- split(row.names(group_file), group_file$Group)
labelInfo <- split(row.names(group_file), group_file$Status)


tree <- groupOTU(tree, groupInfo, group_name = "group")
tree <- groupOTU(tree, labelInfo, group_name = "Status")

# draw tree
p1 <- ggtree(tree, layout="rectangular", ladderize = TRUE, branch.length = "none",aes(color=group)) + 
  geom_tippoint(aes(shape = Status), size = 0.5,color="black") +
  geom_tiplab(color="grey50",hjust=-0.1,size=1,offset=-1) +
  theme(legend.position = "right")

# save graph
filenames <- sub("(_O).*", "", treefile)
output_file <- paste0(filenames, "_tree.tiff")
ggsave(output_file, p1, width = 30, height = 30, units = "cm", dpi = 300,compression = "lzw")
