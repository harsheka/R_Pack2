#include <Rcpp.h>
#include "DynProg.h"
using namespace Rcpp;

// [[Rcpp::export]]
Rcpp::NumericVector cpp_dynamic_prog
  (const Rcpp::NumericVector input_vec,
   const int k_max){
  int n_data = input_vec.length();
 
  Rcout << n_data;
  //if (n_data < 1){
   // return 2;
  //}
  return 0;
}
   