#=
Prime digit replacements

Problem 51

By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.

Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.
=#


# Approach: generate a large list of primes and then search through the cycles that those primes could possibly be in


include("utils/primes.jl")
include("utils/prime_factorization.jl")
include("utils/power_set.jl")

mxd = 6             # thoroughly search for cycles with as many as mxd digits
maxprime = 10^mxd - 1
global nmember = 8  # try to find 8-member cycles

ps = primes(1,maxprime)

using Multisets

function alltemplates(p)
 # given a (prime) number p, find all the templates for cycles it could be in.
 # returns a template. **DATA FORMAT TBD**
 # implement templates as an array of signed integers flag X with value -1

 #ex.    alltemplates(140044)

 pstr = string(p)

 templates = []

 base_template = zeros(Int, length(pstr))  # make a base template that is just an array containing the digits of p
 for i=1:length(pstr)
  base_template[i] = parse(Int, pstr[i])
 end

 pm = Multiset(base_template)
 key=collect(keys(pm))
 val=collect(values(pm))
 for k=1:length(key)
  k_inds = findall(base_template .== key[k])
  k_inds_pow = power_set(k_inds)    # this accounts for different permutations of the Xs
  k_inds_pow = k_inds_pow[2:length(k_inds_pow)]   # remove the empty list
  for i=1:length(k_inds_pow)
   k_inds_temp = k_inds_pow[i]
   if length(k_inds_temp) > 0
    template = deepcopy(base_template)
    template[k_inds_temp] .= -1
     if ((template[length(template)] != -1) | (nmember <= 5))     # optimization: don't need to consider cases where the last digit is an X
                                                                # 5 of the numbers will be even and not prime, leaving only 5 that could possibly be prime
     push!(templates, template)
    end
   end
  end 
 end

 return templates
end


function substitutex(template, X)
 # given a template (e.g., 56XX3, **DATA FORMAT TBD**) and an input X, substitute X in to the template and return an int
 # e.g.    substitutex([5, 6, -1, -1, 3], 4)  # returns 56443
 output = deepcopy(template)
 inds = findall(template .== -1)
 output[inds] .= X
 return  parse(Int, join(output))
end


answer = 0

#MAIN
#loop through the primes

for i_p = 1:length(ps)
 # ** generate an array of cycle templates e.g. 56XX3  **
 p = ps[i_p] 
 templates = alltemplates(p)

 # loop through the templates and see if any one is a 8-member cycle

  for i=1:length(templates)
   template = templates[i]

   X=-1                     # loop through X=0:9, but stop loop early if 2 are found that aren't prime
   count_notprime = 0
   count_isprime = 0
   while (X<9) & (count_notprime < (10 - nmember + 1) )
    X+=1
    test = substitutex(template, X)
    #println(test, isprime(test))
     if isprime(test) & !((X == 0) & (template[1] == -1))
      count_isprime +=1
     else
      count_notprime += 1
     end
   end
   if count_isprime == nmember
    if answer == 0
     global answer = p
    end
    println("$count_isprime member cycle found! p=$p, template = $template")
   end

 end

end


println("the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family is: $answer")

