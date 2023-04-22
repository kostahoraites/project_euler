#=

Coin sums

Problem 31

In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

It is possible to make £2 in the following way:

    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?

=#

#Approach: nested loop
#check the biggest coins "first"
#for a given coin type, only consider a number of that coin that does not exceed the running total
#start with the biggest coins, 

#=
This algorithm is pretty fast!
 horakons@lx1-500-23819:~/project_euler$ time julia p031.jl 
 There are 73682 ways to make £2 using any number of coins. 

 real	0m0.264s
 user	0m0.371s
 sys	0m0.619s
=#

T = 200

coins = [200 100 50 20 10 5 2 1]

#coins = [2 1]

#use a recursive function

combinations = 0

function cointest(T, c)
 denom = c[1]
 numc_max = T÷denom

 if length(c) == 1
   # terminate the recursion, tick up the counter
  global combinations += 1
 else
  for i=0:numc_max
   newT = T-i*denom
   cointest(newT, c[2:length(c)])
  end
 end
end

cointest(T, coins)

print("There are $combinations ways to make £2 using any number of coins. \n")


