#=
Goldbach's other conjecture

Problem 46

It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2×12
15 = 7 + 2×22
21 = 3 + 2×32
25 = 7 + 2×32
27 = 19 + 2×22
33 = 31 + 2×12

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
=#

include("utils/prime_factorization.jl")

maxsearch = 100000


primes = []
squares = Array(1:Int(ceil(sqrt(maxsearch/2)))).^2


for i=1:maxsearch
 if isprime(i)    # use caching?
  push!(primes, i)
 end
end

check = zeros(Int, maxsearch)     # flag all the primes and p+2*s numbers

for i=1:Int(maxsearch/2)
 global check[i*2] = 1                   # flag all the even numbers (looking for odd numbers)
end

for i_p = 1:length(primes)
 global check[primes[i_p]] = 1  # flag all the primes (looking for composite numbers)
 nmaxsquare = Int(ceil(sqrt( (maxsearch - primes[i_p])/2 ) ))
 #for i_s = 1:length(squares)
 for i_s = 1:nmaxsquare
  n = primes[i_p] + (2* squares[i_s])
  if n<=maxsearch
   global check[n] = 1
  end
 end
end


answer = findall(check .== 0)[2]   # ignore ""[1] = 1

println("the smallest odd composite that cannot be written as the sum of a prime and twice a square is: $answer")
