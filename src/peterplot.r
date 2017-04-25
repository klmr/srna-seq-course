#!/usr/bin/env Rscript

args = commandArgs(TRUE)
name = args[1]
infile = args[2]
outfile = args[3]

library(Biostrings)
library(ggplot2)

sequences = readDNAStringSet(infile)

srna_freq = data.frame(Length = width(sequences),
                       Nucleotide = substr(sequences, 1, 1))

ggplot(srna_freq) +
    aes(Length, fill = Nucleotide) +
    geom_bar(aes(y = ..count.. / sum(..count..))) +
    labs(title = name, y = 'Proportion')
