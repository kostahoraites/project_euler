#=
Non-abundant sums

Problem 23

A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
=#


include("utils/divisors.jl")

function d(n)
 if n == 1
  return(0)
 else
  return sum(proper_divisors(n))
 end
end

N = 28123   # max. number that needs to be checked

#find all 

ab = []  # list all the abundant numbers

for n=1:N
 if d(n) > n   # check for abundance
  push!(ab, n)
 end
end

notexpressible = [1:N;]

for i=1:length(ab)
 for j=1:length(ab)
  num1 = ab[i]
  num2 = ab[j]
  ind_sum = num1 + num2
  if ind_sum <= N
   notexpressible[ind_sum] = 0  # the sum of num1 and num2 is expressible
  end
 end
end

answer = sum(notexpressible)

print("the sum of all the positive integers <= $N which cannot be written as the sum of two abundant numbers is: $answer \n")



