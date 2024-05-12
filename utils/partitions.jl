#=
NOTES on the partition function p(n)

p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + ...

i.e.

p(n)= \sum_{k_neq_0} (-1)^(n_k-1) p(n - g_k)

(note p(0) = 1, p(x)=0 for x<0 )

where
 k = 0,1, 2,3, 4,5...
 n_k = 0,1,-1,2,-2,3,-3,4,-4,5,-5, ....
 we can identify    n(k)=(-1)^(k+1) * ceil( k/2 )

and where g_k is the kth generalized pentagonal number

the GENERALIZED pentagonal numbers are also given by the same formula:

 g_k = (3 *n_k^2 - n_k) / 2

this produces the strictly increasing sequence g_k, the generalized pentagonal numbers,  evaluated k=0,1,2,3,4,5:

   g_0, g_1, g_2, g_3, ...
=  0,     1,   2,   5,    7, 12, 15, 22, 26, 35, 40, 51, 57, 70, 77,...


reference: the Pentagonal number theorem https://en.wikipedia.org/wiki/Pentagonal_number_theorem to calculate p(n) efficiently.

Pentagonal numbers
https://en.wikipedia.org/wiki/Pentagonal_number
the pentagonal numbers are given by the formaula p_n = (3 *n^2 - n) / 2
where n = 0,1,2,3,4...
NOTE that the generalized pentagonal numbers used above are the same, but they allow n to be negative (thus the notation n_k)

and the partition number p_n evaluated at n=1,2,3...

p(0) = 1 (by definition?)
p(1) = p(0) = 1
p(2) = p(1) + p(0) = 2
p(3) = p(2) + p(1) = 2 + 1 = 3
p(4) = p(3) + p(2) = 3 + 2 = 5
p(5) = p(4) + p(3) - p(0) = 7
p(6) = p(5) + p(4) - p(1) = 11
p(7) = p(7-g_1) + p(7-g_2) - p(7-g_3) - p(7-g_4)   =  p(6) + p(5) - p(2) - p(0) = 15
p(8) = p(8-g_1) + p(8-g_2) - p(8-g_3) - p(8-g_4) + p(g-g_5)
...

=#



#=
functions implemented below, to be used externally, are partitions() and p()
EXAMPLES

julia> partitions(5)
5-element Array{BigInt,1}:
 1
 2
 3
 5
 7

julia> p(5)
7
=#



# DEFINE n_k(k) and g(k)
# calculate p(n) for many n


n_k(k) = convert( Int64,  (-1)^(k+1) * ceil( k/2 ) )
g(k) = convert(Int64,  (3 *n_k(k)^2 - n_k(k)) / 2 )




#TEST (looks good!)
#
#k=[0 1 2 3 4 5 6 7 8 ]
#print("Testing g_k: \n")
#print(g.(k))



function p(n, p_n_wrt_zero::Array)
 if n < length(p_n_wrt_zero)
  return p_n_wrt_zero[n+1]     # DYNAMIC PROGRAMMING: it saves a ton of time to look up already-computed p(n)
                               # p_n_wrt_zero[n] = p(n-1)
 else
  if n == 0        # maybe can delete this clause?
    return convert(BigInt, 1)
  elseif n>0
   output = 0
   k=1
   while g(k) <= n
    output += (-1)^(n_k(k)-1) * p(n-g(k), p_n_wrt_zero)
    k+=1
   end
   return convert(BigInt, output)
  else
   print("n must be an integer >= 0!")
   return -1
  end
 end
end


function partitions(n::Int)
#=
returns p(i) for i=1,2,3...n as an array
=#
 p_n_wrt_zero = [convert(BigInt, 1)]      # p(0) = 1
                                          # p_n_wrt_zero[n] = p(n-1)
 for ni=1:n
  p_n = p(ni, p_n_wrt_zero)
  push!(p_n_wrt_zero, p_n)       # DYNAMIC PROGRAMMING: it saves a ton of time to look up already-computed p(n)
 end
 return p_n_wrt_zero[2:length(p_n_wrt_zero)]
end


function p(n)
#=
use partitions() to calculate the number of partitions 1...n.
The last element of this array is just p(n)
=#
 p_ns = partitions(n)
 return p_ns[n]
end



#=knowing p(n) this way, it might be fun to also calculate all of the partitions explicitly for a given n.
#probably easy enough to do this recursively. Consider the largest group in the subpartition, then loop through possibilities in remaining part.
e.g. to find the partitions of 5:
 5 = 5
 5 = 4+1
 5 = 3+2
 5 = 3+1+1
 5 = 2+2+1
 5 = 2+1+1+1
 5 = 1+1+1+1+1
#Note: if I write this in a more general way, where each of the terms in the sum comes from a specified list, then can be used to solve a more general class of problems
#such as: how many ways can you make $1 out of quarters, dimes, nickels, and pennies?
#how many ways can you partition whole number N into primes? (see Project Euler problem 77)
=#



