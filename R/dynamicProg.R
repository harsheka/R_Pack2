
#' @export

dynamic_lines = function(data, max_segments,data_title = "logratio"){
  data = data.table(data)
  data_size = nrow(data)
  data [, data_i := 1:data_size]
  blank_matrix = matrix(NA, data_size, max_segments)
  
  loss_matrix= blank_matrix
  last_mean_mat = blank_matrix
  last_change_mat = blank_matrix
  
  
  cum_vec = cumsum(data[[data_title]])
  cum_N = 1:data_size
  loss = function(sum_vec, N_vec){
    -sum_vec^2/N_vec
  }
  loss_matrix[ , 1] = loss(cum_vec, cum_N)
  last_mean_mat[ , 1] = cum_vec/cum_N
  
  loss1_dt = data.table(loss = loss_matrix[ ,1], data_size = cum_N)
  
  for (N_segments in 2:max_segments) {
    for (up_to_t in N_segments:data_size) {
      possible_prev_end = seq(N_segments-1,up_to_t-1)
      prev_loss = loss_matrix[possible_prev_end, N_segments-1]
      
      N_last_segs = up_to_t-possible_prev_end
      sum_last_segs = cum_vec[up_to_t]-cum_vec[possible_prev_end]
      
      last_loss = loss(sum_last_segs, N_last_segs)
      total_loss = prev_loss + last_loss
      best_index = which.min(total_loss)
      last_mean_mat[up_to_t,N_segments] =
        (sum_last_segs/N_last_segs)[best_index]
      last_change_mat[up_to_t, N_segments] =
        possible_prev_end[best_index]
      loss_matrix[up_to_t, N_segments] = total_loss[best_index]
    }
  }
  segment_end = data_size
  segment_dt_list = list()
  for (seg_i in max_segments:1) {
    prev_end = last_change_mat[segment_end, seg_i]
    seg_start = if (seg_i == 1)1 else prev_end+1
    segment_dt_list[[seg_i]] = data.table(seg_start, segment_end, 
                                                      seg_mean = 
                                                        last_mean_mat[segment_end, seg_i])
    segment_end = prev_end
  }
  segment_dt = do.call(rbind, segment_dt_list)
  
}
