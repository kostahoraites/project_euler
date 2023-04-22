
function divrem(num, d)
 #see how many times d divides into num (usually a remainder itself),
 #and calculate the next remainder the long division process
 #returns the quotient and remainder as a two-array [quotient, remainder]
 #EXAMPLE:
 # div, rem = divrem(10,3)   #div=3, rem=1
 if num == 0
  return [0, d]
 else
  #while d>num
  # num *=10
  #end
  remainder = num % d
  div = Int(floor(num/d))
  return [div, remainder]
 end
end


