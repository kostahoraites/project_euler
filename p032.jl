#=
Pandigital products

Problem 32

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

=#


include("utils/pandigital.jl")


pandigitals = zeros(Int, 100000)

# consider products a*b = c where a>b
# let d(X) = # digits of X
# note that   d(a) + d(b)-1 <= d(c) <= d(a) + d(b)
# where d(a)>=1,   d(b)>=d(a),   d(a) + d(b) + d(c) = 9
# we can infer that d(b)<=4. Or else we would produce too many digits
# similarly, d(a) <= 9 - 2*d(b)

d(num) = length(string(num))

max_da(b) = minimum([b-1, 10^(9-2*d(b))-1])

for b=1:9999
 for a=1:max_da(b)
  c = a*b
  str = join([string(a), string(b),string(c)])
  if (ispandigital(str)) & (length(str)==9)
   print("$a * $b = $c", '\n')
   pandigitals[c] = c
  end
 end
end

answer = sum(pandigitals)

print("the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital is: $answer \n")



