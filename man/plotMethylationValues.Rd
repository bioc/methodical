% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{plotMethylationValues}
\alias{plotMethylationValues}
\title{Create a plot of methylation values for methylation sites in a region}
\usage{
plotMethylationValues(
  meth_site_values,
  sample_name = NULL,
  reference_tss = FALSE,
  title = NULL,
  xlabel = NULL,
  ylabel = "Methylation Value",
  value_colours = "set1",
  reverse_x_axis = FALSE
)
}
\arguments{
\item{meth_site_values}{A data.frame with values associated with methylation sites.
Row names should be the coordinates of methylation sites in character format.
All methylation sites must be located on the same sequence.}

\item{sample_name}{Name of column in meth_site_values to plot. Defaults to first column if none provided.}

\item{reference_tss}{TRUE or FALSE indicating whether to show distances on the X-axis
relative to the TSS stored as an attribute \code{tss_range} of meth_site_values.
Alternatively, can provide a GRanges object with a single range for such a TSS site.
In either case, will show the distance of methylation sites to the start of this region with methylation sites upstream
relative to the reference_tss shown first.
If FALSE (the default), the x-axis will instead show the start site coordinate of the methylation site.}

\item{title}{Title of the plot. Default is no title.}

\item{xlabel}{Label for the X axis in the plot. Defaults to "Distance to TSS" if reference_tss is used or
"seqname position" where seqname is the name of the relevant sequence.}

\item{ylabel}{Label for the Y axis in the plot. Default is "Methylation Value".}

\item{value_colours}{A vector with two colours to use, one for low values and the other for high values.
Alternatively, can use one of two predefined colour sets by providing either "set1" or "set2":
set1 uses "#53868B" (blue) for low values and "#CD2626" (red) for high values
while set2 uses "#7B5C90" (purple) for low values and ""#bfab25" (gold) for high values. Default is "set1".}

\item{reverse_x_axis}{TRUE or FALSE indicating whether x-axis should be reversed,
for example if plotting a region on the reverse strand so that left side of plot corresponds to upstream.}
}
\value{
A ggplot object
}
\description{
Create a plot of methylation values for methylation sites in a region
}
\examples{
# Load methylation-values around the TUBB6 TSS
data("tubb6_meth_rse", package = "methodical")
tubb6_meth_rse <- eval(tubb6_meth_rse)

# Extract methylation values from tubb6_meth_rse
tubb6_methylation_values = methodical::extractGRangesMethSiteValues(meth_rse = tubb6_meth_rse)

# Plot methylation values around TUBB6 TSS
methodical::plotMethylationValues(tubb6_methylation_values, sample_name = "N1")

# Create same plot but showing the distance to the TUBB6 TSS on the x-axis
data("tubb6_tss", package = "methodical")
methodical::plotMethylationValues(tubb6_methylation_values, sample_name = "N1",
  reference_tss = tubb6_tss)

}
