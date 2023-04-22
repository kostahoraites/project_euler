#=
Factorial digit sum

Problem 20

n! means n × (n − 1) × ... × 3 × 2 × 1

For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
=#

num = BigInt(1)

for i=1:100
  global num = num*BigInt(i)
end

snum = string(num)

numsum = 0

for i=1:(length(snum))
 global numsum += parse(Int, snum[i])
end

print("the sum of the digits in 100! is: $numsum \n")

