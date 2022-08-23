#=
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10 001st prime number?
=#

using Printf
include("utils/prime_factorization.jl")

global n = 0
global nprimes = 0

while nprimes != 10001
    global n
    global nprimes
    n+=1
    a = prime_factorization(n)
    if size(a)[1] == 1   # only one prime factor, i.e. i is prime
        nprimes += 1
    end
end

@printf("The 10001st prime is: %d \n", n)


#=
alternate approach: starting from the smallest numbers, eliminate all multiples of prime numbers. If it is not certain whether a number is prime, check it explicitly using the routine prime_factorization (from )
=#


