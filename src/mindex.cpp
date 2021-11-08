#include "mindex.h"

// min of an array

int min_val_loc(const double * arr, const int size, int* index){
  *index = 0;
  for ( int i = 1; i < size; i++){
    if(arr[i] < arr[*index]){
      *index = i;            
      }  
  }
  return 0;
}
