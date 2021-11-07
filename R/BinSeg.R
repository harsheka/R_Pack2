
#' @export

loss = function(sq_sums, cum_sum, data_v){
  return(sq_sums - (cum_sum^2 / data_v))
}

binary_segmentation = function(input_data, k_max) {
  input_data_length = length(input_data)
  
  tot_loss =  loss(sum(input_data^2),
                   sum(input_data),
                   input_data_length)
  
  #data frame to keep track of segments
  segments = data.frame(seg_start = 1,
                        seg_end = input_data_length,
                        seg_loss = tot_loss,
                        loss_decrease = NA,
                        optimal_cut_loc = NA,
                        left_seg_loss = NA,
                        right_seg_loss = NA)
  
  square_loss = vector()
  
  for (cut_num in 1:k_max) {
    square_loss[cut_num] = tot_loss
    for (seg_num in 1:cut_num) {
      #if so, calculate optimal cut location and square loss 
      if (is.na(segments[seg_num, "optimal_cut_loc"])) {
        this_segment = data.table(logratio = input_data[
          segments[seg_num, "seg_start"]:segments[seg_num, "seg_end"]])
        seg_length = nrow(this_segment)
        if(seg_length < 2) {
          #can't split this
          segments[seg_num, "left_seg_loss"] = segments[seg_num, "seg_loss"]
          segments[seg_num, "right_seg_loss"] = segments[seg_num, "seg_loss"]
          segments[seg_num, "loss_decrease"] = 0
          segments[seg_num, "optimal_cut_loc"] = segments[seg_num, "seg_start"]
        }
        else {
          
          this_segment[, sum_data := cumsum(logratio)]
          
          cut_option = data.table(
            first_seg_end = seq(1, seg_length-1))
          
          this_segment[, cumsum_sq := cumsum(logratio^2)]
          cut_option[, first_seg_loss := {
            this_segment[
              first_seg_end,
              loss(cumsum_sq, sum_data, first_seg_end)
            ]  
          }]
          
          cut_option[, sum_data_after := {
            this_segment[.N, sum_data] - this_segment[first_seg_end, sum_data]
          }]
          
          cut_option[, cumsum_sq_after := {
            this_segment[.N, cumsum_sq]-
              this_segment[first_seg_end, cumsum_sq]
          }]
          
          cut_option[, data_points_after := nrow(this_segment) - first_seg_end]
          
          cut_option[, second_seg_loss := {
            loss(cumsum_sq_after, sum_data_after, data_points_after)
          }]
          
          cut_option[, decreases := {
            segments[seg_num, "seg_loss"] - (first_seg_loss + second_seg_loss)
          }]
          
          
          largest_dec = which.max(cut_option$decreases)
          segments[seg_num, "left_seg_loss"] =
            cut_option$first_seg_loss[largest_dec]
          segments[seg_num, "right_seg_loss"] =
            cut_option$second_seg_loss[largest_dec]
          segments[seg_num, "loss_decrease"] =
            cut_option$decreases[largest_dec]
          segments[seg_num, "optimal_cut_loc"] =
            largest_dec + segments[seg_num, "seg_start"] - 1
        }
        
      }
    }
    
    cut_seg = which.max(segments$loss_decrease)
    old_start = segments[cut_seg, "seg_start"]
    old_end = segments[cut_seg, "seg_end"]
    this_cut = segments[cut_seg, "optimal_cut_loc"]
    left_seg_loss = segments[cut_seg, "left_seg_loss"]
    right_seg_loss = segments[cut_seg, "right_seg_loss"]
    tot_loss = tot_loss -
      segments[cut_seg, "loss_decrease"]
    
    segments[cut_seg, ] = c(old_start, this_cut, left_seg_loss,
                            NA, NA, NA, NA)
    segments[cut_num+1, ] = c(this_cut+1, old_end, right_seg_loss,
                              NA, NA, NA, NA)
  }
  
  return(square_loss)
  
}
