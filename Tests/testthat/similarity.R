library(binsegRcpp)
library(testthat)
# context("my_cpp_binseg")

test_that("one data point has zero cost", {
  fit <- Rpack2::binseg(5)
  expect_identical(fit[["loss"]], 0)
  expect_identical(fit[["before.mean"]], 5)
})