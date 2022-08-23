#=
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
=#

#returns a 1D array of prime factors:


function prime_factorization(number)
   i = 2
   while i <= floor(sqrt(number)) && number%i != 0
      # find the smallest factor (it will necessarily be prime, otherwise the while loop would have exited  earlier)
      i+=1
   end
   if number == 1
      return []
   elseif number%i == 0
      # number is evenly divisible by a prime number (i)
      # note this encapsulates two cases: 1) i=number is prime, i != number is prime
      return cat([i], prime_factorization(number÷i), dims = [1,1])    # ÷ sign does integer division, returns an int
   else
      #number is prime
      return [number]
   end
end

#
