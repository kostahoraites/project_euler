#=
Coin partitions
Problem 78

Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can be separated into piles in exactly seven different ways, so p(5)=7.
OOOOO
OOOO   O
OOO   OO
OOO   O   O
OO   OO   O
OO   O   O   O
O   O   O   O   O

Find the least value of n for which p(n) is divisible by one million.
=#


### MAIN PROGRAM
# DEFINE n_k(k) and g(k)
# calculate p(n) for many n
#Then just check whether it is evenly divisible by 10^6.



 # see partitions.jl
 # partitions() calculates the partitions efficiently using the recursion relation that follows from Euler's pentagonal number theorem
include("utils/partitions.jl")

ni=100000
p_array = partitions(ni)   # calculates p(n) for n=1,2,3,...,ni
for n=1:length(p_array)
  if p_array[n] % 1000000 == 0   # check if divisible by one million
   p_n = p_array[n]
   print("n = $n \n")
   print("p_n = $p_n \n")
 end
end


print("this is the first divisible by 10^6, could find more by searching larger range of n \n")


#note: this problem could be solved more efficiently by taking mod 1000000 of all the p(n) that appear in the recursive formula.
# (there's no need to calculate these huge BigInt numbers)
