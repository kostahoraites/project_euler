#=
Digit factorials

Problem 34

145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: As 1! = 1 and 2! = 2 are not sums they are not included.
=#

#Note factorial(9) = 362880, a 6 digit number
#therefore the sum of factorials for an 8-digit number could be at most 7 digits.
# i.e. the sum of factorials of an 8-digit number N could never be as large as N itself
# and similarly for any D-digit number with D>8
# So, we only need to search up through the 7-digit numbers


global facts = map(x->factorial(x), Array(0:9))

function sumfacts(n)
 s= 0
 nstr = string(n)
 for i=1:length(nstr)
  s += facts[parse(Int,nstr[i])+1]
 end
 return s
end


sumall = 0


for i=3:9999999  # search up through 7 digits
 #print(sumfacts(i), '\n')
 si = sumfacts(i)
 if si == i
  global sumall += si
 end
end

print("The sum of all numbers which are equal to the sum of the factorial of their digits is: $sumall \n")

