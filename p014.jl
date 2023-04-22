#=

The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:
13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

=#



# AKA the 3N+1 problem
#  --- it's not known for sure whether some sequence goes on forever (presumably by growing to infinity... are infinite loops possible?)

#NOTE: all this dynamic programming stuff was probably unnecessary, could brute force it fast enough
# (esp. since the longest sequence is only 525 terms)


global N = 10000000  # 1e7>>1e6, make this as large as it needs to be
global sl = zeros(Int, N)   # sl: sequence length

function collatz(num::Int)
 # returns the length of the Collatz sequence for a given starting number
 count = 1
 n = num
 while n != 1
  if n%2 == 0  # even
   n = Int(n/2)
  else         # odd
   n = 3*n + 1
  end
  count += 1
 end
 return count
end

# DYNAMIC PROGRAMMING
function collatz_dynamic(num, N)
 # if already calculated, just look up the sequence length
 if num < N
  if sl[num] > 0
   return sl[num]
  else
   return collatz(num)
  end
 else
  return collatz(num)
 end
end

# RECURSION
function collatz_recursive(num, N)
 if num == 1
  this_sl = 1
 else
  if num%2 == 0  # even
   next = Int(num/2)
  else         # odd
   next = 3*num + 1
  end
  if next < N
   this_sl = 1 + collatz_recursive(next, N)   # RECURSION
  else
   this_sl = 1 + collatz(next)   # can't look it up
  end
 end
 sl[num] = this_sl                 # DYNAMIC
 return this_sl
end

# recursion check the length of first 1 million Collatz sequences
for i=1:999999
 dummy = collatz_recursive(i, N)
end

longest = maximum(sl)
print("The longest Collatz (3N+1) sequence with starting number <1e6 is: $longest \n")

startingnum = findall(sl .== 525)
print("starting number of the sequence is $startingnum \n plotting... (?) \n")


# PLOT THE SOLUTION

using UnicodePlots
lineplot(1:1000000, sl[1:1000000], title="Example", name="Collatz sequences (3N+1 problem)", xlabel="starting number", ylabel="sequence length")

