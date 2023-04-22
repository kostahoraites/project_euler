#=
Consecutive prime sum

Problem 50

The prime 41, can be written as the sum of six consecutive primes:
41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?

=#

include("utils/primes.jl")

maxp = 1000000
ps = primes(2, maxp)
np = length(ps)


#approach: first calculate the length Lmax of the longest possible sequence (by summing from the bottom of the sequence until sum>10^6)
#then, sift through the primes to find a sequence that adds to a prime number
# start with sequences of length Lmax, then check Lmax-1, Lmax-2, etc.

cs = cumsum(ps)
i_cs = findall(cs .<= maxp)
Lmax = length(i_cs)     # =564, don't need to check sequences longer than this

answer = nothing

for L=reverse(1:Lmax)
 println("L=$L")
 for i=1:np-L+1
  test = sum(ps[i:i+L-1])
  if (isprime(test)) & (test<maxp) & (answer===nothing)  # a lot of redundant addition here, could optimize
   global answer = "SOLUTION: $test is the sum of $L primes. This is the prime, below one-million, that can be written as the sum of the most consecutive primes."
   println(answer)
  end
 end
end




