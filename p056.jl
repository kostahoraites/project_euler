#=
Powerful digit sum

Problem 56

A googol (10100) is a massive number: one followed by one-hundred zeros; 100100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a^b, where a, b < 100, what is the maximum digital sum?
=#

answer = 0

for a=1:100
 for b=1:100
  s = string( BigInt(a)^BigInt(b) )
  sm = 0
  for i=1:length(s)
   sm += parse(Int, s[i])  # add all the digits
  end
  global answer = maximum([answer, sm])
 end
end


println("Considering natural numbers of the form, a^b, where a, b < 100, the maximum digital sum is: $answer")
