include("prime_factorization.jl")
include("common_factors.jl")
using Multisets

#=  OLD IMPLEMENTATION
function reduced_fraction(num,denom)
 #returns the numerator and denominator of reduced fraction
 # n, d = reduced_fraction(6,15)  # n=2, d = 5. because 6/15 = 2/5
 num_ms = Multiset(prime_factorization(num))
 denom_ms = Multiset(prime_factorization(denom))
 in = intersect(num_ms, denom_ms)
 num_red_ms = num_ms-in + Multiset([1])  # reduce by common factors of numerator and denominator
 denom_red_ms = denom_ms-in + Multiset([1])
 prod(collect(num_red_ms))
 return prod(collect(num_red_ms)),  prod(collect(denom_red_ms))
end
=#


function reduced_fraction(num, denom)
 # NEW IMPLEMENTATION
 factor = gcf(num, denom)
 if factor == 1
  return num, denom
 else
  return reduced_fraction(num÷factor, denom÷factor)  # recursion
 end
end



function is_reduced(num, denom)
    rf = reduced_fraction(num, denom)
    if rf[1] == num
        return true
    else
        return false
    end
end


