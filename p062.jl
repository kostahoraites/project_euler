#=
Cubic permutations

Problem 62

The cube, 41063625 (3453), can be permuted to produce two other cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.
=#

include("utils/is_power.jl")   # is_nth_power(int, n)
include("utils/permutations.jl")


function expand_digs(n)
 a = []
 s = string(n)
 for i=1:length(s)
  push!(a, s[i])
 end
 return a    # return string of Ints, the digits of a
 #return parse.(Int, a)    # return string of Ints, the digits of a
end


function count_powers(int, power)
    # count how many permutations of the integer 'int' are a given power (e.g. for cubes, power =3)
    count = 0
    permutation_array = permutations(expand_digs(int))
    for i=1:length(permutation_array)
        str = permutation_array[i]
        if str[1] != 0   # don't count permutations with leading 0's
            num = parse(Int, join(str))
            if is_nth_power(num, power)
                count += 1
                println(num)
            end
        end
    end
    #println("n^3 = $int , $count powers of degree $power")
    return count
end

# APPROACH: make a sorted list of the integers in each of the cubes, and the resulting string as an identifier. 
# Look for  (use multisets) to check which number

num_permutations = 5
power = 3  # cubes

N =  10000
srtd = []
for i=1:N
    #srtd[i] = parse(Int, join(sort(expand_digs(i))))
    push!(srtd, join(sort(expand_digs(i^power))))
end

mu = Multiset(srtd)

key = collect(keys(mu))    #  the unique identifiers, containing the digits
val = collect(values(mu))  #  the number of times each identifier occurred

dct = pairs(mu)


# a bit inelegant, but oh well... 
answer = 0
i=1
while answer == 0
    cube = i^power
    cubestr = join(sort(expand_digs(cube)))
    if dct[cubestr] == num_permutations
        global answer = i^power
        println("$i cubed = $cube")
    end
    global i += 1
end




#=  This approach should work but it's too slow

m = 1
power = 3   # cubes
#num_permutations = 3    # sanity check, this gives answer=345, as in the problem
num_permutations = 5
while count_powers(m^power, power) != num_permutations
    println("m = $m")
    global m += 1
end

println("the smallest cube for which a total of 5 permutations of its digits are cube is: $m")

=#


