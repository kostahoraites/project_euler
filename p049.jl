#=

Prime permutations

Problem 49

The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this sequence?

=#

include("utils/primes.jl")
include("utils/permutations.jl")

ps = primes(1000,9999)       # 4-digit primes

using Multisets

function perm_digs(n)
 #permute the digits of n, return permuted integers in an array
 sn = string(n)
 arr = zeros(Int, length(sn))
 for i=1:length(sn)
  arr[i] = parse(Int, sn[i])
 end
 perms = permutations(arr)
 return sort(parse.(Int, join.(perms)))
end


for i_p=1:length(ps)
 p_perm = perm_digs(ps[i_p])
 consider = p_perm[findall(isprime.(p_perm))]  # find the permutations that are prime, nly need to consider these
 c1 = ps[i_p]
 for i_c2=1:length(consider)                    # using the fact the required sequences have three terms, could generalize
  c2 = consider[i_c2]
  d = c2 - c1  #difference
  ds = consider .- c2
  check = findall(ds .== d)
  if length(check) >0
   c3 = consider[check[1]]
   if c1!=c2!=c3
    println("$c1  $c2  $c3")
   end
  end
 end
end

println("the three terms in the other 4-digit increasing sequence or primes that are permutations of each other, concatenate to the number 296962999629")
