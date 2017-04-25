#!/usr/bin/env Rscript

args = commandArgs(TRUE)
name = args[1]
infile = args[2]
outfile = args[3]

library(ShortRead)
library(ggplot2)

sequences = readFasta(infile)

srna_freq = data.frame(Length = width(sequences),
                       Nucleotide = substr(sread(sequences), 1, 1))

p = ggplot(srna_freq) +
    aes(Length, fill = Nucleotide) +
    geom_bar(aes(y = ..count.. / sum(..count..))) +
    labs(title = name, y = 'Proportion')

ggsave(outfile, p)
