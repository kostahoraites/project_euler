#=
Power digit sum

Problem 16

215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?
=#


num = BigInt(1)

for i=1:1000
 num*=2
end

snum = string(num)

snumsum = 0
for i=1:length(snum)
 global snumsum += parse(Int, snum[i])
end

print(snumsum, '\n')

