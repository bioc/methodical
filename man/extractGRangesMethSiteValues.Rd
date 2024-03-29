% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meth_rse_functions.R
\name{extractGRangesMethSiteValues}
\alias{extractGRangesMethSiteValues}
\title{Extract values for methylation sites overlapping genomic regions from a methylation RSE.}
\usage{
extractGRangesMethSiteValues(
  meth_rse,
  genomic_regions = NULL,
  samples_subset = NULL,
  assay_number = 1
)
}
\arguments{
\item{meth_rse}{A RangedSummarizedExperiment for methylation data.}

\item{genomic_regions}{A GRanges object. If set to NULL, returns all methylation sites in meth_rse}

\item{samples_subset}{Optional sample names used to subset meth_rse.}

\item{assay_number}{The assay from meth_rse to extract values from. Default is the first assay.}
}
\value{
A data.frame with the methylation site values for all sites in meth_rse which overlap genomic_ranges.
Row names are the coordinates of the sites as a character vector.
}
\description{
Extract values for methylation sites overlapping genomic regions from a methylation RSE.
}
\examples{
# Load sample RangedSummarizedExperiment with CpG methylation data
data(tubb6_meth_rse, package = "methodical")
tubb6_meth_rse <- eval(tubb6_meth_rse)

# Create a sample GRanges object to use
test_region <- GRanges("chr18:12305000-12310000")

# Get methylation values for CpG sites overlapping HDAC1 gene
test_region_methylation <- methodical::extractGRangesMethSiteValues(meth_rse = tubb6_meth_rse, genomic_regions = test_region)
}
