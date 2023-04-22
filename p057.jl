#=
Square root convergents

Problem 57

It is possible to show that the square root of two can be expressed as an infinite continued fraction.

sqrt(2) = 1 + (1 / (2 + 1/(2 + 1/(2 + 1/(2 + 1/(2+ ...))))))

By expanding this for the first four iterations, we get:

1 + 1/2 = 3/2 = 1.5
1+1/(2+1/2) = 7/5 = 1.4
1+ 1/(2+1/(2+1/2)) = 1.41666...
1+ (four iterations) = 1.41379...

The next three expansions are
99/70,
239/169, and
577/408, but the eighth expansion,

1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a numerator with more digits than the denominator?
=#


include("utils/reduced_fraction.jl")


function expand_frac(frac)
 # frac is a tuple of integers (numerator, denominator )
 newfrac= (BigInt(2)*frac[2] + frac[1], frac[2])
 return (newfrac[2], newfrac[1])
end

function root2_approx(iterations)
 frac = (BigInt(1),BigInt(2))
 for i = 1:iterations-1
  frac = expand_frac(frac)
 end
 frac = (frac[2] + frac[1], frac[2])
 #return reduced_fraction(frac[1], frac[2])   # numerator, denominator
 return (frac[1], frac[2])   # numerator, denominator
end

answer = 0

for i=1:1000
 num, denom = root2_approx(i)
 if length(string(num)) > length(string(denom))
  global answer +=1
 end
end


#NOTE: I assumed that these fractions couldn't be further reduced, which is kind of a big assumption

print("In the continued fraction expansions of sqrt(2) with a finite number of fractional expansions (<1000 iterations), $answer of them have a numerator with more digits than the denominator")

