#include <Rcpp.h>
#include "DynProg.h"
#include <array>

using namespace Rcpp;

NumericVector cpp_cum_sum1(NumericVector x){
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

NumericVector Cost(NumericVector cumsum_vec, NumericVector position_vec){
  NumericVector Cost_vec(cumsum_vec.length());
  for(int i; i<cumsum_vec.length(); i++){
    Cost_vec[i]= (-1*pow(cumsum_vec[i],2))/position_vec[i];
  }
  return Cost_vec;
}
// RCPP_ADVANCED_EXCEPTION_CLASS implimentation
int vec_min_index(NumericVector x){
  NumericVector::iterator it = std::min_element(x.begin(),x.end());
  return it - x.begin();
}


// [[Rcpp::export]]
Rcpp::NumericVector cpp_dynamic_prog
  (const Rcpp::NumericVector input_vec,
   const int k_max){
  int n_data = input_vec.length();
  int size = n_data;
  //Rcout << n_data <<"\n";
  
  //initialize the cost matrix with zeros
  NumericMatrix cost_mat( n_data, k_max);
  //
  //Rcout << cost_mat<<"\n";
  NumericVector cumsum(cpp_cum_sum1(input_vec));
   // Rcout << cumsum<<"\n";
    
  NumericVector loc(n_data);
  std::iota(loc.begin(), loc.end(),1);
  //Rcout<<loc<<"\n";
  
  NumericVector our_cost = Cost(cumsum, loc);
 // Rcout<<our_cost<<"\n";
  //Rcout << "updated cost mat is:"<<"\n";
  cost_mat(_,0)= our_cost;
  //Rcout << cost_mat<<"\n";
  
  for(int i=1; i<k_max; i++){
  
    //int prev_i = i-1;
  
    for (int ii = i; ii<n_data; ii++){
      NumericVector pos_last_end(ii);
      
      std::iota(pos_last_end.begin(), pos_last_end.end(),i);
      NumericVector prev_i_vec(pos_last_end.length(),i);
      NumericVector all_prev_costs= Cost(pos_last_end, prev_i_vec);
     
      NumericVector rev_pos_last_end(ii);
      std::iota(rev_pos_last_end.begin(), rev_pos_last_end.end(),i);  // might  be prev_i instead of ii
      std::reverse(rev_pos_last_end.begin(), rev_pos_last_end.end());
      NumericVector last_seg_sums(ii);
      
      for (int iii = 0; iii< ii; iii++){
        last_seg_sums[iii] = cumsum[ii] - cumsum[iii];
      }
      NumericVector last_costs = Cost(last_seg_sums, rev_pos_last_end);
      
      NumericVector tot_cost(ii);
      for (int iii = 0; iii< ii; iii++){
        tot_cost[iii] = all_prev_costs[iii] + last_costs[iii];
      }
      
      int best_option = vec_min_index(tot_cost);  // index of minimum val
      //Rcout<<tot_cost<<"\n";
      //Rcout<<best_option<<"\n";
      cost_mat(ii,i)= tot_cost[best_option] ;
      
    }
  }
  
  Rcout<< cost_mat<<"\n";
  
  return 0;
}
 
