#=
Distinct powers

Problem 29

Consider all integer combinations of a^b for 2 ≤ a ≤ 5 and 2 ≤ b ≤ 5:

    2^2=4, 2^3=8, 2^4=16, 2^5=32
    3^2=9, 3^3=27, 3^4=81, 3^5=243
    4^2=16, 4^3=64, 4^4=256, 4^5=1024
    5^2=25, 5^3=125, 5^4=625, 5^5=3125

If they are then placed in numerical order, with any repeats removed, we get the following sequence of 15 distinct terms:

4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125

How many distinct terms are in the sequence generated by a^b for 2 ≤ a ≤ 100 and 2 ≤ b ≤ 100?
=#

#Approach, avoid using BigInts.
#Instead, note that each number has a unique prime factorization
#represent each number's factorization as a Multiset
#then list all the unique numbers as a set of Multisets

include("utils/prime_factorization.jl")
using Multisets

function pf_ms(num)  # prime factorization multiset
  return Multiset(prime_factorization(num))
end

nums = []

for a=2:100
 for b=2:100
  pf_ms_a = pf_ms(a)  # prime factorization of a, [Multiset]
  pf_ms_ab = b * pf_ms_a  # repeat the factors b times
                          # note: order of multiplication matters!
                          # for Multiset M, 2*M != M*2
  push!(nums, pf_ms_ab)
 end
end


using Multisets
m = Multiset(nums)
key = collect(keys(m))  # count the unique numbers
answer = length(key)

print("There are $answer distinct terms in the sequence generated by a^b for 2 ≤ a ≤ 100 and 2 ≤ b ≤ 100. \n")
