#=
Permuted multiples
Problem 52

It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
=#

include("utils/permutations.jl")

function expand_digs(n)
 a = []
 s = string(n)
 for i=1:length(s)
  push!(a, s[i])
 end
 return parse.(Int, a)    # return string of Ints, the digits of a
end

maxnum = 1000000

nums = zeros(Int, maxnum)

numdigs = []

for i=1:maxnum
 push!(numdigs, expand_digs(i))
end


for n=1:maxnum
 ns = expand_digs.([n, 2*n, 3*n, 4*n, 5*n, 6*n])
 test = true
 for i=2:6
  if !ispermutation(ns[1],ns[i])
   test = false
  end
 end
 if test == true
  println("the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits is: $n")
 end
end










