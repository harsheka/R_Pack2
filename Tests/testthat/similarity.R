library(Rpack2)
library(testthat)
# context("min_index")

test_that("min_index finds the index of the minimum value of a vector", {
  expect_equal(min_index(c(1,0,1,2,1)), 1)
  expect_equal(min_index(c(-1,1,0,1,2,1)), 0)
  expect_equal(min_index(c(1,0,1,2,1,55,3,99)), 7)
})
#> Test passed