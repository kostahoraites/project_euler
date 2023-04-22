#=
Combinatoric selections
Problem 53

There are exactly ten ways of selecting three from five, 12345:

123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, 

/5\
\3/ = 10


In general, /n\ =   n!/ (r! * (n-r)!)
            \r/                        , where  r <= n

.

It is not until n=23, that a value exceeds one-million:

/23\
\10/ = 1144066.


How many, not necessarily distinct, values of  /n\
                                               \r/
for  1<=n<=100, are greater than one-million?
=#


# just use the formula
# could implement this a bit more cleverly, but it runs fast enough as-is.


nchooser(n, r) =   factorial(big(n))/ (factorial(big(r)) * factorial(big(n-r)))

count = 0
for n=1:100
 for r = 1:n
  if nchooser(n,r) > 1000000
   global count+=1
  end
 end
end

println("There are $count, not necessarily distinct, values of (n choose r)  for  1<=n<=100,  greater than one-million.")



