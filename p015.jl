#=
Lattice paths

Problem 15

Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?
=#

#Observation: on an NxN grid, need to make exactly N right moves and N down moves in some sequence
# so there are 2 *N moves in total and two groups of N are identical 

#multiplicity can be calculated using the binomial coefficient (2*N  N) =  (2*N)! / (N!)^2
# = ( (N+1) * (N+2)  * (N+3) ... (2*N)) / N!

a = BigInt(1)
b = BigInt(1)

for i=21:40
    a*=i
end

for i=1:20
    b*=i
end


print(BigInt(a/b), "\n")




