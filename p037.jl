#=
Truncatable primes
Problem 37

The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
=#


include("utils/prime_factorization.jl")

function truncations(strnum; l2r::Bool=true)
    output = [strnum]
    l = length(strnum)
    if l >= 2
        if l2r
         return append!(output, truncations(strnum[2:l], l2r=true))
        else
         return append!(output, truncations(strnum[1:l-1], l2r=false))
        end
    else
        return output   # base case (one character)
    end
end



function both(num)
   str = string(num)
   all_truncs = append!(truncations(str, l2r=true), truncations(str, l2r=false))
   all_truncs = parse.(Int, all_truncs)
   mapreduce(isprime, &, all_truncs)   # return true if ALL truncations are prime, left-to-right and right-to-left
end



num = 10  # don't consider 1-digit primes
tot = 0
np = 0
while np < 11
 if both(num)
  println(num)
  global np += 1
  global tot += num
 end
 global num += 1
end

println(" the sum of the only eleven primes that are both truncatable from left to right and right to left is: $tot")

