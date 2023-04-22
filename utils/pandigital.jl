#=
function ispandigital(str)
 # str is string of a positive integer
 # print(ispandigital("12543"))
 l = length(str)
 flag = zeros(Int, l)
 isp = true
 for i=1:l
  dig = parse(Int, str[i])
  if (dig > l) | (dig == 0)
   return false
  else
   flag[dig] = 1
  end
 end
 if sum(flag) == l
  return true
 else
  return false
 end
end
=#


function ispandigital(str; minnum = 1)
 #more general than the implementation above
 # str is string of a positive integer
 # examples: these are all true
 # print(ispandigital("12543"))
 # print(ispandigital("01423"; minnum=0)
 # print(ispandigital("345768"; minnum=3))
 maxnum = minnum+length(str)-1
 l = maxnum-minnum+1
 flag = zeros(Int, l)
 isp = true
 for i=1:length(str)
  dig = parse(Int, str[i])
  if (dig > maxnum) | (dig < minnum)
   return false
  else
   flag[dig + 1 - minnum] = 1
  end
 end
 if sum(flag) == l
  return true
 else
  return false
 end
end



