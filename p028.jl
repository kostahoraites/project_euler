#=
Number spiral diagonals

Problem 28

Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

=#

#Notice: for an NxN square (N odd, N != 1),
#  the upper right corner of the spiral is N*N,
#  the upper left corner of the spiral is N*N -N+1,
#  the lower left corner of the spiral is N*N - 2*N + 2,
#  the lower right corner of the spiral is N*N - 3N + 3,
# i.e. the 4 corners sum to 4*N^2 - 6*(N - 1)
# note edge case: if N=1, the sum of the corners is 1


sum = 0
spiralsize = 1001

for N=1:2:spiralsize
 if N==1
  global sum+=1
 else
  global sum += 4*N^2 - 6*(N - 1)
 end
end



print("the sum of the numbers on the diagonals in a 1001 by 1001 spiral (as stated in the problem) is: $sum")



