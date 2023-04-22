include("utils/prime_factorization.jl")
using Multisets


function common_prime_factors(num_array)
 # find the common prime factors of an array of numbers
 # return as an array
 # common_prime_factors(6,12,24)
 global in = Multiset(prime_factorization(num_array[1]))
 for i=2:length(num_array)
  in = intersect(in, Multiset(prime_factorization(num_array[i])))
 end
 return collect(in)
end

common_prime_factors(a,b) = common_prime_factors([a,b])


function gcf(num_array)
 # Greatest Common Factor
 return prod(common_prime_factors(num_array))
end

gcf(a,b) = gcf([a,b])

