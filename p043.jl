#=
Sub-string divisibility
Problem 43

The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

    d2 d3 d4=406 is divisible by 2
    d3 d4 d5=063 is divisible by 3
    d4 d5 d6=635 is divisible by 5
    d5 d6 d7=357 is divisible by 7
    d6 d7 d8=572 is divisible by 11
    d7 d8 d9=728 is divisible by 13
    d8 d9 d10=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
=#

#approach, make all ~3+ million pandigital numbers by permuting the integers
#then check if each of these pandigitals has the required property

# note the problem is a bit weird because it seems to imply that a number can lead with a "0"

#define function to check for substring divisibility.

function substrdiv(d)
    #input is an array of digits,
    # example: substrdiv([1,4,0,6,3,5,7,2,8,9])   #returns 1406357289 (because it is "substring divisible")
    if (d[6] == 0) | (d[6] == 5)
     if d[4] % 2 == 0
      if (d[3]+d[4]+d[5]) % 3 == 0   # well-known test for divisibility by 3
       if parse(Int,join(d[5:7])) % 7 == 0
        if (d[6] + d[8] - d[7]) % 11 == 0      # divisibility rule by 11 sum of odd digits minus the even digits (from the right) is divisible by 11
         if parse(Int, join(d[7:9])) % 13 == 0
          if parse(Int, join(d[8:10])) % 17 == 0
           return parse(BigInt, join(d))   # true
          end
         end
        end
       end
      end
     end
    end
    # ...else
    return 0        #  (not "substring divisible")
end




## make all the pandigitals

include("utils/permutations.jl")

p = permutations([0,1,2,3,4,5,6,7,8,9])


answer = mapreduce(substrdiv, +, p)    # convert to strings 
                                       # join() works on strings of numbers and makes a concatenated string


print("the sum of all 0 to 9 pandigital numbers with the property stated in the problem is: $answer")




