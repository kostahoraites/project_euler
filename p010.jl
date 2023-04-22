
#=
Summation of primes

Problem 10

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.

=#


include("utils/prime_factorization.jl")

sum = 0

for i=1:2000000-1
 if isprime(i)
   global sum += i
  end
end

print(sum, "\n")


