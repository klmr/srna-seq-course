#!/usr/bin/env Rscript

args = commandArgs(TRUE)
infile = args[1]
outfile = args[2]

library(ShortRead)

read_bam = function (file) {
    # TODO: Implement.
    #library(Rsamtools)
}

gz_file_ext = function (filename) {
    pos = regexpr('\\.([[:alnum:]]+)(\\.gz)?$', filename)
    ifelse(pos > -1L, substring(filename, pos + 1L), '')
}

reader = switch(gz_file_ext(infile),
                fq = , fastq = , fq.gz = , fastq.gz = readFastq,
                sam = , bam = read_bam)

sequences = reader(infile)
seq_freq = tables(sequences, length(sequences))$top
ids = paste(seq_along(seq_freq), seq_freq, sep = '-')
as_fasta = ShortRead(DNAStringSet(names(seq_freq)), BStringSet(ids))

writeFasta(as_fasta, outfile, compress = grepl('\\.gz$', outfile))
