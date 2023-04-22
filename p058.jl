#=
Spiral primes

Problem 58

Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

37 36 35 34 33 32 31
38 17 16 15 14 13 30
39 18  5  4  3 12 29
40 19  6  1  2 11 28
41 20  7  8  9 10 27
42 21 22 23 24 25 26
43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
=#



#Notice: for an NxN square (N odd, N != 1),
#  the upper right corner of the spiral is N*N,
#  the upper left corner of the spiral is N*N -N+1,
#  the lower left corner of the spiral is N*N - 2*N + 2,
#  the lower right corner of the spiral is N*N - 3N + 3,
# note edge case: N=1

include("utils/prime_factorization.jl")


num_prime = 0
spiralsize = 101

N = 1
rat = 1

while rat > 0.1
 global N += 2 
 UR = N*N
 UL = N*N - N + 1
 LL = N*N - 2*N + 2
 LR = N*N - 3*N + 3
 if isprime(UR)
  global num_prime += 1
 end
 if isprime(UL)
  global num_prime += 1
 end
 if isprime(LL)
  global num_prime += 1
 end
 if isprime(LR)
  global num_prime += 1
 end
 tot = 1 + 2*(N-1)   # number of diagonal elements
 global rat = num_prime / tot
 #println(N, " ", rat)
end

answer = N

println("the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10% is: $answer")
