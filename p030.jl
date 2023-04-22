#=

Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

    1634 = 14 + 64 + 34 + 44
    8208 = 84 + 24 + 04 + 84
    9474 = 94 + 44 + 74 + 44

As 1 = 14 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

=#

function sumpow(num, pow)
 str = string(num)
 result = 0
 for i=1:length(str)
  result += (parse(Int, str[i]))^pow
 end
 return result
end


pow = 5
sumnums = 0


# upper limit of numbers that could satisfy num = sumpow(num, pow) is num = pow*9^pow
# i.e. if all the digits are 9s 
# ... i think, maybe this needs a closer check

for i=2:pow*9^pow   # note: 1 is not included
 if i == sumpow(i, pow)
  global sumnums += i
 end
end


print("the sum of all the numbers that can be written as the sum of {$pow}th powers of their digits is: $sumnums")



