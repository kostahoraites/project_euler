#=
Special Pythagorean triplet

Problem 9

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a^2 + b^2 = c^2

For example, 32 + 42 = 9 + 16 = 25 = 52.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

=#

# FOR DEEPER ANALYSIS SEE:
# https://math.stackexchange.com/questions/423196/derivation-of-pythagorean-triple-general-solution-starting-point
# Also note that pythagorean fomula for natural numbers a,b,c is a diophantine equation (basically, an equation where you want to find the integer solutions)

# easy approach: clearly any a,b,c must be <1000. So just loop

for c=1:1000
 for b=1:c-1
  for a = 1:b-1
   if (a^2 + b^2 == c^2) & (a + b + c == 1000)
    abc = a*b*c
    print("a=$a, b=$b, c=$c \n product a*b*c=$abc \n")
   end
  end
 end
end

