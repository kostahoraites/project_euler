#=
Lexicographic permutations

Problem 24

A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
=#


include("utils/permutations.jl")
p = permutations(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
p_str = []
for i=1:length(p)
 push!(p_str, join(p[i]))
end

p_str = sort(p_str)

answer = p_str[1000000]

print("the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9 is: $answer \n")

