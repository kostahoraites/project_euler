#=
Number letter counts

Problem 17

If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
=#


zero2nine = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
one2ninetynine = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
	          "eleven","twelve","thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

tens = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

for i=1:8
 for j=1:10
  push!(one2ninetynine, join([tens[i], zero2nine[j]] )) 
 end
end

nums = one2ninetynine

for i=2:10
 for j=0:99
  str=join([zero2nine[i],"hundred"])
  if j != 0
   str = join( [str, "and",one2ninetynine[j]] )
  end
  push!(nums, str)
 end
end

#now add the thousand
push!(nums, "onethousand")

nums = join(nums)

print("the first 1000 numbers are spelled with ", length(nums), " letters \n")

