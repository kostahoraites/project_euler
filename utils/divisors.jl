include("prime_factorization.jl")
using Multisets

function num_divisors(n::Int)
   #=
    num_divisors(n) returns the number of unique divisors of the (positive) whole number n 

    interesting fact: the number of divisors is equal to product((M_p+1))
    where M_p is the multiplicity of each unique prime factor p

    this is because if a term P in the prime factorization of N has multiplicity M_p, 
    then P can appear with M_p+1 different multiplicities in the various factors of N: 0,1,2,3,... M_p
      
    as an example, 1 (which divides everything) is the case where all the prime factors of N have multiplicity 0
    similarly, N (which always divides N) is the case where all the prime factors of N are at maximum multiplicity m_p

    Example: N= 28 = 2*2*7       M_2=2, M_7 = 1
             number of divisors of N: (M_2 + 1) * (M_7 + 1)  = 3 * 2 = 6
             explicitly, these 6 divisors of 28 are: 1,2,4,7,14,28
   =#

   pf = Multiset(prime_factorization(n))
   primes = collect(keys(pf))        # keys(pf) gives the unique elements of the multiset pf
   M_p = collect(values(pf))         # values(pf) gives the multiplicities of these unique elements
   return prod( M_p .+1 )            # product((M_p+1))
end


