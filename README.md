# R_Pack2
Binary segmentation model and Dynamic Programming

# Installation
via remotes
if(require("remotes"))install.packages("remotes")
remotes::install_github(“https://github.com/harsheka/R_Pack2”)

# Usage/Examples
Usage which shows a few lines of R code about how to use your package

binary_segmentation:
Rpack2::binary_segmentation(data_vector, max_segments)

Rcpp binary segmentation
Rpack2::rcppbinseg(data_vector, max_segments)

Rpack2::cpp_dynamic_prog(data_vector, max_segments)
  takes in 2 arguments, a data vector that can be interperted as a NumericVector, and an integer maximum number of segments.  returns a loss matrix for all points in all segments.
ex.
> Rpack2::cpp_dynamic_prog(c(1,1,1,1,1,6,6,6,6,6,6),2)

-1.00000 0.00000
-2.00000 -2.00000
-3.00000 -3.00000
-4.00000 -4.00000
-5.00000 -5.00000
-20.1667 -41.0000
-41.2857 -77.0000
-66.1250 -113.000
-93.4444 -149.000
-122.500 -185.000
-152.818 -221.000


Rpack2::dynamic_lines(data_vector, max_segments)

Rpack2::cppcumsum(NumericVector)

Rpack2::min_index(cpp.array)


# Other Packages Used

This package contains core elements from BisegCPP by TOby Dlan Hocking https://github.com/tdhock/binsegRcpp.  These components were used as guides and tests throughout and demonstrate some stability of my package implimentation and structure.  binsegCPP is in no way my original work.
