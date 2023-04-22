#=
Quadratic primes
Problem 27

Euler discovered the remarkable quadratic formula:

n^2 + n+ 41
It turns out that the formula will produce 40 primes for the consecutive integer values 0<=n<=39. However, when n=49, 40^2+40+41 = 40*(40+1) + 41 is divisible by 41, and certainly when n=41, 41^41 + 41 + 41  is clearly divisible by 41.

The incredible formula n^2 - 79*n + 1601 was discovered, which produces 80 primes for the consecutive values 0<=n<=79.  The product of the coefficients, −79 and 1601, is −126479.

Considering quadratics of the form:

n^2 + a*n + b, where |a|<1000 and |b| <1000

where |n| is the modulus/absolute value of n
e.g. |11|=11 and  |-4| = 4

Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n=0.

=#

# notice: this is another diophantine equation, we are looking for integer (prime) solutions

include("utils/prime_factorization.jl")

q(n, a, b) = n^2 + a*n + b

product = 0
maxprimes = 0

for a=-999:999
 for b=-1000:1000
  n=0
  cont = true  # continue
  while cont
   num = q(n, a, b)
   if num > 0
    if isprime(num) == false
     cont = false
    end
   else
    cont = false
   end
   n +=1
   #print(n, '\n')
  end
  if n>maxprimes
   #print(a, ' ', b, '\n')
   global maxprimes = n
   #print("maxprimes = $maxprimes \n")
   global product = a*b
  end
 end
end

maxprimes-=1
print("max number of primes = $maxprimes \n")
answer = product

print("the product of the coefficients, a and b, for the quadratic expression n^2 + a*n + b that produces the maximum number of primes for consecutive values of n, starting with n=0, IS: $answer \n")
