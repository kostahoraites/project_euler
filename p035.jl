#=
Circular primes
Problem 35

The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?
=#

#Approach: use a mapreduce function
#map: for any (prime) number, return 1 if it is a cirular prime, 0 otherwise
#reduce: add all the primes

include("utils/prime_factorization.jl")

function rotate_str(str)
  if length(str) <= 1
    return str
  else
    rotated = join([str[2:length(str)], str[1]])
    return rotated
  end
end

function iscircular(pstr)
 for i=1:length(pstr)
  pstr = rotate_str(pstr)
  if !isprime(parse(Int, pstr))
   return 0
  end
 end
 #(else:)
 return 1
end

primes = []

for i=1:1000000
 if isprime(i)
  push!(primes, string(i))
 end
end

answer = mapreduce(iscircular, +, primes )

println("There are $answer circular primes below one million.")


