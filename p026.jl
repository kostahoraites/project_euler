#=
Reciprocal cycles
Problem 26

A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

    1/2	= 	0.5
    1/3	= 	0.(3)
    1/4	= 	0.25
    1/5	= 	0.2
    1/6	= 	0.1(6)
    1/7	= 	0.(142857)
    1/8	= 	0.125
    1/9	= 	0.(1)
    1/10	= 	0.1 

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
=#



# Consider the process of long division: 1.00000... divided by some positive integer N
# At each step of the division, there will be some remainder X. So the next step of the division 
# will be to see how many times N goes into X with some appropriate number of zeros after it.
# There can only be (N-1) non-zero remainders at each step of this process: 1, 2, 3, ... N-1.
# So if there is a cycle in the decimal representation of the division result, 
# **the cycle must have N-1 digits in it or less.**

#Similarly, we can infer that if the decimal sequence has more than N (or N-1?) elements in it, it must be a repeating sequence

# Approach: calculate long division manually, and keep track of which remainders <N have been seen.
# If a remainder repeats, then this is a cycle.


# NOTE: A faster, easier way would involve checking whether each number d divides evenly into some sequence of repeating 9s. e.g. 1/7 = 0.142857 repeating because 1428257/999999 = 1/7 exactly.
# see "repeating decimals as infinite series" in Wiki article --- https://en.wikipedia.org/wiki/Repeating_decimal
# example of how 1/99..99  gives a repeating sequence of 0.{00..001}...
# julia> 1 / 9999
# 0.00010001000100010001



include("utils/divrem.jl")

N=999
cycle_lengths = zeros(Int, N)

decimals = []

for d=1:N
#for d=42:42
 decimal = ""
 i_seen_wrt0 =  zeros(Int, (d+1)*10)  # keep track of which division step 
                           # (between 1 and d) the given remainders were seen
                           # i_see_wrt0[1] gives the index when remainder zero was seen
                           # i_see_wrt0[2] gives the index when remainder one was seen, etc.
 re = 1 # initialize, dividing d into 1
 i = 0
 while (i_seen_wrt0[re+1] == 0) & (re != 0)
  if i> d
   #global i_seen_wrt0[re+1] = i   # mark as visited with the division step number i
   i_seen_wrt0[re+1] = i   # mark as visited with the division step number i
  end
  div, re_new = divrem(re, d)
  #print("$decimal \n")
  #print("i= $i \n")
  #print("div = $div, re_new = $re_new \n")
  decimal = join([decimal, string(div)])
  re = re_new
  if re < d
   re*=10
  end
  i += 1
 end
 if re != 0
  cycle_lengths[d] = i - i_seen_wrt0[re+1]
 else
  cycle_lengths[d] = 0   # no cycle, division just terminated with remainder of zero
 end
 if length(decimal)>=2
  push!(decimals, join([decimal[1], ".", decimal[2:length(decimal)]]) )
 else
  push!(decimals, "0")
 end
end

#print(decimals, '\n')
print(cycle_lengths, '\n')
answer =findall( cycle_lengths .== maximum(cycle_lengths))


print("the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part is: $answer \n")


