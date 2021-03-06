% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ReadOutputASC.R
\name{readOutput.B90}
\alias{readOutput.B90}
\title{Read LWF-Brook90 output files}
\usage{
readOutput.B90(directory)
}
\arguments{
\item{directory}{directory with LWF-Brook90 .ASC-outputfiles}
}
\value{
a named list containing the data from outputfiles. Each list item  corresponds
to one file.
}
\description{
Reads all files in LWF-Brook90 output directory and returns them as a list of data.tables
}
