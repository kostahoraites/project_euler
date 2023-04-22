#=
Digit cancelling fractions

Problem 33

The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.

=#

include("utils/reduced_fraction.jl")
using Multisets

#consider n/d with n<d

nums = []
denoms = []

fracs = []

for d=11:99  # 11:99
 for n=10:d-1
  # reduced fraction
  nd_r = reduced_fraction(n, d)  # [num, denom]

  # "inexperienced" simplification
  n_str = string(n)
  d_str = string(d)
  n_m = Multiset([parse(Int, n_str[1]), parse(Int, n_str[2])])
  d_m = Multiset([parse(Int, d_str[1]), parse(Int, d_str[2])])
  common = intersect(n_m, d_m)
  if (0∈ common) | (length(keys(common)) != 1)
   # do nothing
   #if both numerator and denominator end in zero, considered trivial
  else
   #print("n=$n, d=$d,  common = $common\n")
   if length(keys(common)) == 0
    global n_inexp = n
    global d_inexp = d
   else
    global n_inexp = collect(n_m - common)[1]
    global d_inexp = collect(d_m - common)[1]
   end
   nd_r_inexp = reduced_fraction(n_inexp, d_inexp)  # [num, denom]
   if nd_r == nd_r_inexp
      # if reduced numerator and denominator are the same, the numbers are equal
      push!(nums, n)
      push!(denoms, d)
      push!(fracs, join([string(n), "/", string(d)]))
   end
  end
 end
end

n_final, d_final = reduced_fraction(prod(nums), prod(denoms))


#Cool! the product of the four digit canceling fractions is 1/100
print("the four non-trivial digit canceling fractions are: $fracs \n")
print("the denominator (in lowest terms) of the product of these four fractions is: $d_final \n")



