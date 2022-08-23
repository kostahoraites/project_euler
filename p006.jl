#=
Sum square difference

Problem 6

The sum of the squares of the first ten natural numbers is,

385

The square of the sum of the first ten natural numbers is,

3025

Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is

3025-385=2640

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
=#

nums = 1:100

sumsquares = sum(map(x->x^2, nums))
squaresums = (sum(nums))^2

print(squaresums - sumsquares)

