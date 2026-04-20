source ~/.bashrc
conda activate tree
mafft --retree 1 --maxiterate 0 --nofft --thread 88 13woryzae.NBARC.fa > 13woryzae.NBARC.aligned.fas
fasttree -fastest -lg 13woryzae.NBARC.aligned.fas > 13woryzae.NBARC.tree
