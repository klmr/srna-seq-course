#!/usr/bin/env Rscript

args = commandArgs(TRUE)
bedfile = args[1]
infile = args[2]
outfile = args[3]
region = args[4]

library(ggplot2)
library(rtracklayer)

annotation = import(bedfile)
annotation = annotation[mcols(annotation)$name == region]

bam = import(infile)

overlaps = subsetByOverlaps(bam, annotation)

p = ggplot(as.data.frame(overlaps)) +
    aes(x = start) +
    geom_density(fill = 'black') +
    ggtitle(paste('Chr ', seqnames(annotation)))

ggsave(outfile, p, width = 10, height = 2)
