#=
Self powers

Problem 48

The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
=#

#Approach, use modular arithmetic (only need the last 10 digits at any point of the calculation)
# higher digits can be discarded

m = 10^10

function mpow(n, m)
 result = 1
 for i=1:n
  result = (result * n) % m
 end
 return result
end

answer = 0
for i=1:1000
 global answer = (answer + mpow(i, m)) % m
end


println("the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000 is:  $answer")   # note: if answer has leading zeros, need to add them back in (turns out to be unnecessary for this problem)




