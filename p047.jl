#=
Distinct primes factors

Problem 47

The first two consecutive numbers to have two distinct prime factors are:

14 = 2 × 7
15 = 3 × 5

The first three consecutive numbers to have three distinct prime factors are:

644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Find the first four consecutive integers to have four distinct prime factors each. What is the first of these numbers?

=#


include("utils/prime_factorization.jl")

n_consec = 4
n_count = 0
i=0


while n_count < n_consec
 global i+=1
 distinct = length(Set(prime_factorization(i)))
 if distinct == n_consec
  global n_count += 1
 else
  global n_count = 0
 end
end


answer = i - n_consec +1 

print("Considering the first four consecutive integers to have four distinct prime factors each--- The first of these 4 numbers is: $answer")
