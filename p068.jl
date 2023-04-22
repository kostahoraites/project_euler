#=
Magic 5-gon ring

Problem 68

Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6, and each line adding to nine.

Working clockwise, and starting from the group of three with the numerically lowest external node (4,3,2 in this example), each solution can be described uniquely. For example, the above solution can be described by the set: 4,3,2; 6,2,1; 5,1,3.

It is possible to complete the ring with four different totals: 9, 10, 11, and 12. There are eight solutions in total.
Total	Solution Set
9	4,2,3; 5,3,1; 6,1,2
9	4,3,2; 6,2,1; 5,1,3
10	2,3,5; 4,5,1; 6,1,3
10	2,5,3; 6,3,1; 4,1,5
11	1,4,6; 3,6,2; 5,2,4
11	1,6,4; 5,4,2; 3,2,6
12	1,5,6; 2,6,4; 3,4,5
12	1,6,5; 3,5,4; 2,4,6

By concatenating each group it is possible to form 9-digit strings; the maximum string for a 3-gon ring is 432621513.

Using the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings. What is the maximum 16-digit string for a "magic" 5-gon ring?
=#


#=
Example magic 5-gon by construction:

     6
      \
       \      7
        3    / 
      /   \ /
     /     5
    1      /
   / \    /
  /   4---2---8
 10    \
        \
         9

All lines add to 14. The string encoding in this case is 16 digits: 635 752 824 941 1013 

Approach:
brute force. Calculate all 10! ~ 3 million permutations. Note that due to the rotational symmetry, this will count each arrangement (encoded by a 16- or 17-digit string) 5 times. 
For each permutation, encode it as a string and then find the maximum value among the 16-digit strings.

=#

function is_magic_ngon(arr)
    # test if an n-gon is magic, i.e. the branches all add to the same number
    # Example: is_magic_ngon([10, 6, 7, 8, 9, 1, 3, 5, 2, 4]) # true
    N = convert(Int, length(arr)/2)   # assume length(arr) is even
    val = arr[1] + arr[1+N] + arr[1+N+1]
    for i=2:N
        i2 = N + mod1(i+N, N)   # mod1 like mod, but modN returns values 1-N instead of 0-(N-1)
        i3 = N + mod1(i+N+1, N)
        test = arr[i] + arr[i2] + arr[i3]
        # println(test)
        if test != val
            return(false)   # the sums of two branches differ, not magic
        end
    end
    return true   # all branches check out... magic!
end

function ngon_string(arr)
    # take a 2*N array of numbers representing the (magic) ngon and compute the string encoding described in the problem
    # Example: ngon_string([10, 6, 7, 8, 9, 1, 3, 5, 2, 4]) # 6357528249411013
    N = convert(Int, length(arr)/2)   # assume length(arr) is even
    i0 = argmin(arr[1:N])    # find the 'finger' with the mininum value, to use as a starting point
    output = ""
    for i=i0:i0+N-1
        i1 = mod1(i, N)
        i2 = N + mod1(i1+N, N)
        i3 = N + mod1(i1+N+1, N)
        output = output * string(arr[i1]) * string(arr[i2]) * string(arr[i3]) # concatenate elements
    end
    return output
end

include("utils/permutations.jl")

# indexing:
# in each permutation array of length 2*N, the first N numbers represent the outer fingers and the second N numbers represent the inner N-gon
# i.e. if N=5, index 1 is a finger extending from index 6, and index 2 is a finger extending from index 7, etc. (1-6, 2-7, 3-8, 4-9, 5-10)

N = 5     # 3
p = permutations(Array(1:2*N))

lp = length(p)

answer = 0
for i=1:lp
    ns = ngon_string(p[i])
    test = parse(Int, ns)
    if is_magic_ngon(p[i]) && test > answer && length(ns) == 16
        global answer = test   # update answer
    end
end

println("The maximum 16-digit string for a magic 5-gon ring is $answer")

#=
solution: 6531031914842725

The solution n-gon looks like this:

     6
      \
       \      10
        5    / 
      /   \ /
     /     3
    2      /
   / \    /
  /   4---1---9
 7    \
       \
        8
=#






