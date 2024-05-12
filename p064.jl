#=
Odd Period Square Roots
Problem 64

All square roots are periodic when written as continued fractions and can be written in the form:
sqrt(N) = a0 + 1/(a1 + (1/(a2 + 1/(a3 + ...))))

For example, let us consider sqrt(23):
...

If we continue we would get the following expansion:
sqrt(23) = 4 + 1/(...)
sqrt(23) = 4 + 1/(1 + (1/(3 + 1/(1 + 1/(8 + ...)))))

The process can be summarised as follows:
...

It can be seen that the sequence is repeating. For conciseness, we use the notation [4; (1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.

The first ten continued fraction representations of (irrational) square roots are:

sqrt(2) = [1;(2)], period=1
sqrt(3) = [1;(1,2)], period=2
          etc.
sqrt(5)=, period=
sqrt(6)=, period=
sqrt(7)= [2;(1,1,1,4)], period=4
sqrt(8), period=
sqrt(10), period=
sqrt(11), period=
sqrt(12), period=
sqrt(13), period=Exactly four continued fractions, for N <= 13, have an odd period.

How many continued fractions for N <= 10000 have an odd period?
=#


# use cfrac_sqrt_N() to find the non-repeating and repeating parts of the continued fractions.
include("utils/continued_fraction.jl")
include("utils/is.jl")

answer = 0
for N=1:10000
    if is_square(N) == false
        a, r = cfrac_sqrt_N_coeffs(N)
        if is_odd(length(r))
            global answer += 1
        end
    end
end

print("$answer continued fractions for N <= 10000 have an odd period. \n")
