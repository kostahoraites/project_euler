#=
Ordered fractions

Problem 71

Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.
=#


# First note that the full set of ordered fractions of the form n/d with d ≤ 10^6 may be expected to have \lesssim (10^6)^2 = 10^12 elements.
# So it's probably too slow to search through them all...
# Instead, use this approach: i
# 1. for a given d<10^6, find the largest integer n<d s.t. n/d < 3/7.
# 2. Then, if n/d turns out not to be a reduced proper fraction, decrement it (n=n-1) until it is reduced.
# 3. Iterating through d gives the largest reduced proper fraction that is <3/7 for EVERY d ≤ 1,000,000
# 4. The largest among the 1,000,000 numbers found in the above step will be the final answer

include("utils/reduced_fraction.jl")


M=1000000
global ns = zeros(M)
ds = Array(1:M)

for d=3:M
    n_guess = convert(Int, ceil(d * 3 / 7))   # step 1

    while (is_reduced(n_guess, d) == false) | ((n_guess/d) >= 0.999999999 * 3/7)       # step 2, 0.999999.. is a klug (not sure why i needed this)
        n_guess -= 1 
    end
    
    ns[d] = n_guess                 # ~step 3
    println(ns[d],' ', d)
end

println("will take a minute...")

numbers = ns ./ ds
lt_ind = numbers .< 3/7
numbers_lt = numbers[lt_ind]

i = argmax(numbers_lt)


answer = ns[i]
d_answer = ds[i]


println("The numerator of the fraction immediately to the left of 3/7 is $answer. The fraction itself is $answer / $d_answer")


