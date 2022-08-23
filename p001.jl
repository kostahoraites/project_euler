#=

Multiples of 3 or 5

Problem 1

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
=#


#=
note: sum of all multiples of N up to M*N is    ( M * (M+1)/2 )* N
    where  ( M * (M+1)/2 ) is the Mth triangle number
example: sum of all multiples of 3 up to 3*5  =  3 + 6 + 9 + 12 + 15 = 45
                                          or   = (5*6 / 2) * 3 = 45
=#

max_multiple = 1000 - 1     # = 999, "below 1000"

sum = 0


N = 3
M = floor(max_multiple / N)

sum += ( M * (M+1)/2 )* N

N = 5
M = floor(max_multiple / N)

sum += ( M * (M+1)/2 )* N



# now, need to subtract all the multiples of 15! (so they aren't double counted)


N = 15
M = floor(max_multiple / N)

sum -= ( M * (M+1)/2 )* N

print(Int(sum), "\n")




