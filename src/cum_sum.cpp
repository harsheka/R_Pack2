#include <Rcpp.h>
#include <vector>
#include <numeric> 
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector cppcumsum(NumericVector x){
  // initialize an accumulator variable
  double acc = 0;
  
  // initialize the result vector
  NumericVector res(x.size());
  
  for(int i = 0; i < x.size(); i++){
    acc += x[i];
    res[i] = acc;
  }
  return res;
}

