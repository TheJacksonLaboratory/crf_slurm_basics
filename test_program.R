#!/home/kostim/bin/Rscript

## simple example executable R script
##   counts number of lines in file
##   single argument is path to file
##   reports input file path and number of lines to stdout

args <- commandArgs(trailingOnly=T)

if(length(args) != 1) stop("Usage: test.R file_in.txt")
file_in <- args[1]
cat("R file_in: '", file_in, "'\n", sep='')

contents <- tryCatch(
  suppressWarnings(readLines(file_in)), 
  error=function(e) {
    message("Error reading '", file_in, "': ", e$message)
    q(save='no')
  }
)

nlines <- length(contents)
cat("R nlines:", nlines, "\n")

