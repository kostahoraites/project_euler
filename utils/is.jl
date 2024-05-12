function is_even(N::Int)
    check = Int(floor(N/2))*2
    return check == N
end

function is_odd(N::Int)
    check = Int(floor(N/2))*2
    return check != N
end


function is_square(N::Int)
    sq_rt = Int(floor(sqrt(N)))
    if sq_rt^2 == N
        return true
    else
        return false
    end
end


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
