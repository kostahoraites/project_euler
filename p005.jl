#=
Smallest multiple

Problem 5

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

=#

using Multisets
include("utils/prime_factorization.jl")

prime_factors = Multiset([])

for num=1:20
 prime_factors = union(prime_factors, Multiset(prime_factorization(num)))
end

prime_factors = collect(prime_factors)      # convert to an array

answer = 1
for i=1:length(prime_factors)
 answer*=prime_factors[i]
end

