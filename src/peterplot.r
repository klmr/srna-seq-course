#!/usr/bin/env Rscript

args = commandArgs(TRUE)
name = args[1]
infile = args[2]
outfile = args[3]

library(Biostrings)
library(dplyr)
library(tibble)
library(ggplot2)

sequences = readDNAStringSet(infile)

srna_freq = tibble(Length = width(sequences),
                   Nucleotide = substr(sequences, 1, 1)) %>%
    filter(Nucleotide != 'N') %>%
    group_by(Length, Nucleotide) %>%
    summarize(N = n()) %>%
    ungroup() %>%
    mutate(Proportion = N / sum(N))

ggplot(srna_freq) +
    aes(Length, Proportion, fill = Nucleotide) +
    geom_bar(stat = 'identity') +
    scale_x_continuous(limits = c(18, 46)) +
    ggtitle(name)
