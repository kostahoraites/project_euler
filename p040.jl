#=
Champernowne's constant

Problem 40

An irrational decimal fraction is created by concatenating the positive integers:

0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If dn represents the nth digit of the fractional part, find the value of the following expression.

d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

=#




dig(n) = Int(floor(log(10, n))) + 1     # function that gives the number of digits in an expression

nums = [1, 10, 100, 1000, 10000, 100000, 1000000]
 #nums = [1, 10, 20, 21]

digs = []  # want to multiply the ds as per the problem
i_champ=0  # how many digits of Champernowne's constant have been accounted for
z = 1   # the next integer z that will be added to the trailing decimal
inum = 1

champ = ""  # construct the constant (comment out for long numbers)



i_champ = 0

while i_champ<=maximum(nums)
 d = dig(z)
 global i_champ+=d
 champ *= string(z)
 global z +=1
end

for i=1:length(nums)
 push!(digs, parse(Int, champ[nums[i]]))
end

answer = prod(digs)

println("The product of the 1,10,100,1000, 10000, 100000, 1000000th digits of Champernowne's constant is: $answer")







#Tried a faster approach (below) it worked except it missed the 1000000th digit for some reason


#=
while i_champ<=maximum(nums)
 d = dig(z)
 # check if we are crossing one of the wanted digits
 if inum <= length(nums)
  if i_champ+d >= nums[inum]
   zstr = string(z)
   #find digits in zstr that need to be counted towards final answer
   for i=1:d
    #println( i_champ+i - nums[inum] )
    if inum <= length(nums)
     if Int(i_champ+i - nums[inum] ) == 0
      push!(digs, parse(Int, zstr[i]))
      global inum += 1
     end
    end
   end
  end
 end
 global i_champ+=d
 #println("z = $z, d = $d, i_champ = $i_champ, champ = $champ, inum = $inum")
 champ *= string(z)
 global z +=1

=#








