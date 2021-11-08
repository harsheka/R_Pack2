#include <Rcpp.h>
#include "mindex.h"


// [[Rcpp::export]]
int min_index(NumericVector arr){
  int size = arr.length();
  int result;
  int status = min_val_loc( &arr[0], size, &result);
  
  return result;
}

