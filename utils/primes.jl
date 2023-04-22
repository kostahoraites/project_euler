include("prime_factorization.jl")

function primes(pmin = 1, pmax = 10000)
 # return all the primes in a specified range
 # (a slow way, look into other methods. Maybe apply a sieve of eratosthenes?)
 # note: above, pmin and pmax are not keywords, they are positional arguments with defaults
 # try: primes()        # 1 to 10000
 #      primes(5000)     # 5000 to 10000
 #      primes(40,73)    # 40 to 73

 ps = []
 
 #find the primes between pmin and pmax
 for i=pmin:pmax
  if isprime(i)    # use caching?
   push!(ps, i)
  end
 end
 return ps
end
 
 
 

