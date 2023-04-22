#=

Pandigital multiples

Problem 38

Take the number 192 and multiply it by each of 1, 2, and 3:

    192 × 1 = 192
    192 × 2 = 384
    192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
=#


include("utils/pandigital.jl")


function catprod(num , n)
 #"concatenated product"
 out = ""
 for i = 1:n
  out *= string(i * num)
 end
 return parse(BigInt, out)
end

panmax = 0


for n=2:9
 for num = 1:10^((10 ÷ n)+1)   # no need to search higher, any larger numer will create too many digits
 testnum = catprod(num, n)
  if testnum > panmax
   if ispandigital(string(testnum))
    println(testnum)
    global panmax = testnum
   end
  end
 end
end

print("the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1 is: $panmax")

