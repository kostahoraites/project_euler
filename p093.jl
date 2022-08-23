#=
Arithmetic expressions
Problem 93

By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, −, *, /) and brackets/parentheses, it is possible to form different positive integer targets.

For example,

8 = (4 * (1 + 3)) / 2
14 = 4 * (3 + 1 / 2)
19 = 4 * (2 + 3) − 1
36 = 3 * 4 * (2 + 1)

Note that concatenations of the digits, like 12 + 34, are not allowed.

Using the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.

Find the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.

=#


# note: the # of possible binary arrangements of N quantities is at bounded from above by (N-1)!
# example: there is only one way to arrange N=2 (a,c)
#          two ways to arrange N=3:             (a,(b,c)) and ((a,b),c)   --> this comes from expanding either a or c in the N=2 case ()
# Could imagine expanding a,b,c to get 4 terms in the N=4 case. This yields at most (2*3) possibilities
#But it's a little less because of overlapping arrangements. 

#make a list of generic functions that accounts for e
#don't specify the values of a,b,c,d


funcs = []

ops = [+,-,/,*]

for i=1:4
 for j=1:4
  for k=1:4
   # There are 5 possible arrangements of N=4 quantities connected by binary operators:
   # So, define 5 generic functions
   push!(funcs, ( (a,b,c,d) -> ops[i](ops[j](ops[k](a,b),c),d) ) )     #    (((,),),)
   push!(funcs, ( (a,b,c,d) -> ops[i](ops[j](a,ops[k](b,c)),d) ) )     #    ((,(,)),)
   push!(funcs, ( (a,b,c,d) -> ops[i](a,ops[j](b,ops[k](c,d))) ) )     #    (,(,(,)))
   push!(funcs, ( (a,b,c,d) -> ops[i](a,ops[j](ops[k](b,c),d)) ) )     #    (,((,),))
   push!(funcs, ( (a,b,c,d) -> ops[i](ops[j](a,b),ops[k](c,d)) ) )     #    ((,),(,))
  end
 end
end

# set specific values of a,b,c,d where each number is 1-9 with no repeats, and a<b<c<d (126 combinations in total)

abcds = []
#require a<b<c<d
for d=1:9
 for c=1:d-1
  for b=1:c-1
   for a=1:b-1
    push!(abcds, [a,b,c,d])
   end
  end
 end
end



include("utils/permutations.jl")

#loop through all 126 combinations of a,b,c,d, where  a<b<c<d
#and loop through all 4! = 24 permutations per a,b,c,d combination
#and loop through all 5*64=320 arithmetic functions
#check if the result is a natural number

consecutive_1_n = zeros(Int, length(abcds))



for i=1:length(abcds)
 nats = zeros(Int, 10000) # boolean array for the natural numbers 1-10000
                    # nats[n]=1 where a permutation/function combination resulted in the given natural number n
                    # i.e. keep track of which natural numbers >0 have been found already
 constants = abcds[i]
    #constants = [1,2,3,4]  #test, should lead to consecutive_1_n = 28 everywhere
 #use permutations.jl to enumerate the possible permutations of a,b,c,d (the 4 distinct numbers 1-9)
 abcd_perms = permutations(constants)
 for j=1:length(funcs)
  f = funcs[j]
  for k=1:length(abcd_perms)
   a = abcd_perms[k][1]
   b = abcd_perms[k][2]
   c = abcd_perms[k][3]
   d = abcd_perms[k][4] 
   n = f(a,b,c,d)
   if (n == abs(floor(n))) & (n > 0) & (abs(n) != Inf) 
    nats[Int(n)] = 1   # set to true
   end
  end
 end
 nconsec = 0
 i_nats = 1
 while nats[i_nats] == 1
  nconsec +=1
  i_nats +=1
 end
 consecutive_1_n[i] = nconsec
end

maxstreak = maximum(consecutive_1_n)
i_final = findall(x->x==maxstreak, consecutive_1_n)
abcd_final = abcds[i_final] 

print("the longest streak is n=1,2,3,..$maxstreak \n")
print("produced by the combination of numbers $abcd_final \n")



#op1, op2, op3 can be:  +,-,/,*     any number of repeats allowed
# a,b,c,d (the 4 distinct numbers 1-9)

#assign with:
#f=((a,b,c,d) -> p(p(a,b),  p(c, d)))





