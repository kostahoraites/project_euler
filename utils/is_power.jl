function is_nth_power(int, n)
 # println( is_nth_power(64,2))  # true: 64 = 8^2
 # println( is_nth_power(64,3))  # true: 64 = 4^3
 test = int^(1/n)
 return round(test)^n == int
end



#=
function is_power(int)
  #loop through possible n=2,3,4... and check if it is an nth power  
end
=#
