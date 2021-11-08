# R_Pack2
Binary segmentation model and Dynamic Programming

# Installation
via remotes
if(require("remotes"))install.packages("remotes")
remotes::install_github(“https://github.com/harsheka/R_Pack2”)

# Usage/Examples
Usage which shows a few lines of R code about how to use your package

binary_segmentation:
Rpack2::binary_segmentation_Dr_Hocking(data_vector, max_segments)
  takes in a numeric vecotr and number of segments
  full documentation https://github.com/tdhock/binsegRcpp
> Rpack2::rcpp_binseg_Dr_Hocking(c(1,1,1,1,1,6,6,6,6,6,6),2)
$loss
[1] -152.8182 -221.0000

$end
[1] 10  4

$before.mean
[1] 3.727273 1.000000

$after.mean
[1] Inf   6

$before.size
[1] 11  5

$after.size
[1] -2  6

$invalidates.index
[1] -2  0

$invalidates.after
[1] -2  0
Rcpp binary segmentation
Rpack2::rcppbinseg(data_vector, max_segments)

Rpack2::cpp_dynamic_prog(data_vector, max_segments)
  takes in 2 arguments, a data vector that can be interperted as a NumericVector, and an integer maximum number of segments.  returns a loss matrix for all points in all segments.
ex.
> Rpack2::cpp_dynamic_prog(c(1,1,1,1,1,6,6,6,6,6,6),2)
<<<<<<< HEAD

=======
>>>>>>> 5a98a8800fbf4e8f21fcedf4e363c79dd7e5dc9a
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


Rpack2::dynamic_lines(data_vector, max_segments, data_title= "logratio")
  takes a data table and assumes a column has name "logratio", if it does not you may rename what column the function looks for with a third argument
  ex.
  > data_dt = nb_dt[profile.id=="4" & chromosome=="2"]
> object = Rpack2::dynamic_lines(data_dt,2)


Rpack2::cppcumsum(NumericVector)
takes a numeric vector of doubles and calculates the cumulative sum
ex.
k= cppcumsum(c(1,2,3,4,5))
k= (1,3,6,10,15)

Rpack2::min_index(cpp.array)
  This is the only working original code that actually uses CPP and an interface to run as intended.  It takes an array of doubles and returns the index of the smallest value.
  ex.
  > Rpack2::min_index(c(0,2,2,7,8,-0.1))


[1] 5
remember that c++ is a 0-indexed language.

# Other Packages Used

This package contains core elements from BisegCPP by TOby Dlan Hocking https://github.com/tdhock/binsegRcpp.  These components were used as guides and tests throughout and demonstrate some stability of my package implimentation and structure.  binsegCPP is in no way my original work.
