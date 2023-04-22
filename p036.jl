#=
Double-base palindromes

Problem 36

The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
=#


include("utils/change_base.jl")

function check(num10)
 #check if both base 10 and 2 representations are palindromes
 str10 = string(num10)
 str2 = change_base(num10, 10, 2)
 if (str10 == reverse(str10)) & (str2 == reverse(str2))
  return num10
 else
  return 0
 end
end

answer = mapreduce( check, +, 1:999999)


print("the sum of all numbers, less than one million, which are palindromic in base 10 and base 2, is: $answer")


