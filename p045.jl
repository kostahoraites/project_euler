#=

Triangular, pentagonal, and hexagonal

Problem 45

Triangle, pentagonal, and hexagonal numbers are generated by the following formulae:
Triangle 	  	Tn=n(n+1)/2 	  	1, 3, 6, 10, 15, ...
Pentagonal 	  	Pn=n(3n−1)/2 	  	1, 5, 12, 22, 35, ...
Hexagonal 	  	Hn=n(2n−1) 	  	1, 6, 15, 28, 45, ...

It can be verified that T285 = P165 = H143 = 40755.

Find the next triangle number that is also pentagonal and hexagonal.

=#


# note: there is a formula for the generalization of triangle numbers for more sides
# "s-gon numbers" see utils/sgon.jl

include("utils/sgon.jl")


n = 286  
while (is_sgon(triangle(n), 5) == 0) | (is_sgon(triangle(n), 6) == 0)
 println(n)
 global n+=1
end

println(n)

answer = triangle(n)

println("After T_285 = 40755, the next triangle number that is both
        pentagonal and hexagonal is: T_$n = $answer.")

