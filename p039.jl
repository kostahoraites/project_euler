#=
Integer right triangles

Problem 39

If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?
=#


#=
sees https://en.wikipedia.org/wiki/Pythagorean_triple

Background: use Euclid's formula. Pythagorean triples a,b,c can be found from pairs of two integers m>n. a,b,c are given by:

a = m^2 - n^2       
b = 2*m*n
c = m^2 + n^2

Elementary algebra confirms that this construction satisfies a^2 + b^2 = c^2. 
Also note that if m,n integers, a,b,c will also be integers which is what we want

NOTE: Euclid's formula does NOT produce all triples. insert an additional integer k>=1:

a = k * (m^2 - n^2)    
b = k * (2*m*n)
c = k * (m^2 + n^2)

Searching through all m > n >=1 and k>=1 will produce all the pythagorean triples

(note, if a triple cannot be reduced, it is called a primitive triple.
       E.g. (3,4,5) is primitive but (6,8,10) is not)


(some other interesting properties:
for any primitive Pythagorean triple:
  -a,b,c are all coprime (they share no common divisors),
  -and exactly one of a,b,c is even while the others are odd)

Approach: 

At first it would seem best to search through all c>b>a, s.t. c^2<1000. (c<32)
But it's more efficient to search through the m>n, s.t. m^2 < c < 32    (i.e. m<6)
then multiply the triples found by k, as necessary
=#


np = 1000
ntriples = zeros(Int, np)
alltriples = []


for p=1:np
 triples = []
 #for m=1: 6
 for m=1: Int(ceil(sqrt(floor(sqrt(p)))))  # I "think" this is right..
  for n=1:m-1
   maxk = Int( ceil( p/ (2*(m^2 + n^2)) ) ) 
   for k=1:maxk
    a = k * (m^2 - n^2)
    b = k * (2*m*n)
    c = k * (m^2 + n^2)
    k += 1
    if (a + b + c) == p
     println("Triple! a=$a, b=$b, c=$c.  Perimeter = $p")
     push!(triples, Set([a, b, c]))
    end
   end
  end
 end
 triples = Set(triples)   # set of sets (finds the UNIQUE combinations of a,b,c)
 push!(alltriples, triples)
 global ntriples[p] = length(triples)
end


maxtriples = maximum(ntriples)
answer = findall(ntriples .== maxtriples)
print(answer)


