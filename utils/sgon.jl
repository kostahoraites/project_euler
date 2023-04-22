#=
https://en.wikipedia.org/wiki/Polygonal_number

The square numbers are familiar                       1, 4, 9, 16...   s(n)=n^2
The triangle numbers are also really useful           1, 3, 6, 10...   t(n) = n* (n+1) / 2   
The pentagonal numbers also have applications to the theory of parititions.  p(n) = (3 * n^2 - n) / 2

General formula :
If s is the number of sides in a polygon, the formula for the nth s-gonal number P(s,n) is:

P(s, n) = ( (s-2)*n^2 - (s-4) * n )/ 2

or 

P(s,n) = (s-2) * n * (n-1) / 2 + n
=#


function sgon(s, n)
    #s in number of sides, returns nth s-gonal number
    return Int((s-2) * n * (n-1) / 2 + n)
end


function triangle(n)
    return sgon(3, n) 
end


function pentagon(n)
    return sgon(5, n)
end


function is_sgon(P, s)
    # check if a number P is an s-gonal number
    # quadratic equation:
    # a*n^2 +b*n +c = 0
    a = (s-2) / 2      #>0
    b = -(s-4) / 2
    c = -P             #<0
    # only need to consider the (+) solution:
    sol = (-b + sqrt(b^2 - 4*a*c)) / (2*a)       # >0
    if sol == floor(sol)
        return Int(sol)    # n:   P is the nth s-gon number
    else
        return 0           # false
    end
end



