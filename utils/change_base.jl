#change the base of a number

function sym2num(sym)
 nums= Dict('0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'a' => 10, 'b' => 11, 'c' => 12, 'd' => 13, 'e' => 14, 'f' => 15)
 return nums[sym]
end


function num2sym(num)
 symbs = "0123456789abcdef"   # assume base1, base2 < 16
 return symbs[num+1]
end


function base10rep(numstr, base)
 total = 0
 pow = 0
 for i = reverse(1:length(numstr))
  c=numstr[i]
  total += (sym2num(c) * (base^pow))
  pow += 1
 end
 return total
end



function change_base(num, base1, base2)
 #= 
 Change num from base1 to base2
 assume base1, base2 < 16
 julia> change_base("1101",2,3)
  111
 =#
 num = string(num)
 if base1 != 10
  num10 = base10rep(num, base1)
  return change_base(string(num10), 10, base2)  # recursion! convert to base 10 as an intermediate step
 else
  maxpow = Int(floor(log(base2, parse(Int, num))))
  digs = zeros(Int, maxpow+1)
  global numtmp = parse(Int, num)
  global pow = maxpow
  while (numtmp != 0)
  #for i=reverse(1:maxpow)
   dig = numtmp ÷ base2^pow
   digs[pow+1] = dig
   global numtmp -= dig * base2^pow
   global pow -= 1
  end
 end
 return join(map(string, reverse(digs)))
end


