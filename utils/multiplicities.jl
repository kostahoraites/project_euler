#calculate multiplicities

function list_multiplicities(max_mult_arr)
 # e.g., list_multiplicities( [2,3,5] )
 # there should be (2+1)*(3+1)*(5+1) different combinations        
 # note: multplicity of zero is an option
 # each combination is different item in the final array
 l = length(max_mult_arr)
 if length(max_mult_arr) == 1
  return 0:max_mult_arr[1]
 else
  out = []
  for i=0:max_mult_arr[1]
   lm = list_multiplicities(max_mult_arr[2:l])  # recursion
   for j=1:length(lm)
    push!(out, append!([i], lm[j] ))
   end
  end
  return out
 end
end


