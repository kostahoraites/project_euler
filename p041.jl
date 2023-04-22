#=
Pandigital prime
Problem 41

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
=#

using Printf

include("utils/permutations.jl")
include("utils/prime_factorization.jl")

function make_int(a::Array)
    # concatenate elements of a permutation (an array), into a single string
    output = ""
    for i in 1:length(a)
        output = output * string(a[i])
    end
    output = parse(Int, output)
    #println(output)
    return(output)
end


global largest = 1

for n in 1:9
    global largest
    p = permutations(Array(1:n))
    for i in 1:length(p)
        thisint = make_int(p[i])
        if thisint > largest
            if length(prime_factorization(thisint)) == 1   # is prime
                println(thisint)
                largest = thisint
            end    
        end
    end
end

@printf("The largest pandigital prime is %d ", largest)

