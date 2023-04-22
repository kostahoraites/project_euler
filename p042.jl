#=
Coded triangle numbers

Problem 42

The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
=#


#note: the data and "word value" are the same as in problem #22 (copy/pasted most code below)

# READ DATA

f = open("data/p042_words.txt", "r")
# to count total lines in the file
line_count = 0             
 
for line in readlines(f)
    #note: there's only one line
    global names = split(line, ',', keepempty=false) 
end
close(f)

names = sort(names)

let2num = Dict('A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 
               'K' => 11, 'L' => 12, 'M' => 13, 'N' => 14, 'O' => 15, 'P' => 16, 'Q' => 17, 'R' => 18, 'S' => 19, 
               'T' => 20, 'U' => 21, 'V' => 22, 'W' => 23, 'X' => 24, 'Y' => 25, 'Z' => 26)


function value(name)
    v=0
    for j=1:length(name)
     v += let2num[name[j]]
    end
    return v
end

vals = value.(names)


function istriangle(t)               #see sgon.jl for a more general is_sgon() function
 #solve for n from input t and see if it is an integer
 # (1/2)n^2 + (1/2)n - t_n = 0 # solve for n
 #solutions: -1/2 + sqrt(1/4 + 2*t+n)   # only + solutions are positive

 n = -1/2 + sqrt(1/4 + 2*t)
 return (n == floor(n))
end


answer = mapreduce(istriangle, +, vals)


println("of the given common words, $answer are triangle words")


