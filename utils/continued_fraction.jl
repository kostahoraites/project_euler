include("reduced_fraction.jl")

function func_ai_exp(i)
 # e = [2; 1,2,1,1,4,1,1,6,1,1,8...]
 if i==0
  return 2
 else
  if ((i+1)%3 == 0) 
   return 2*(i+1)÷3
  else
   return 1
  end
 end
end

function func_ai_sqrt2(i)
 # sqrt(2) = [1, (2)]
 if i == 0
  return 1
 else
  return 2
 end
end


function make_func_ai_sqrt_N(N::Int)
 # Example: func_ai_sqrt_5 = make_func_ai_sqrt_N(5)
 coeffs = cfrac_sqrt_N_coeffs(N)   # array [a0, a1, a2, a3, ...]
 function output_func(i)
  if i==0
   return coeffs[1][1]  # a0
  else
   seq = coeffs[2]
   l = length(seq)
   return seq[(i-1)%l + 1]
  end
 end
 return output_func
end


function continued_fraction(func_ai, nterms)
 #=
  Evaluate continued fraction of the form:
  a0 + 1 / (a1 + 1/(a2 + 1/(a3 + 1/(a4 + 1/(...)))))
   --> as implemented here, everything to the right of a0 is "extra_frac"
  func_ai(i) is a function that returns a_i given i   (see example func_ai_sqrt2 above)
  output:
   the reduced form of the specified continued fraction expansion, up to nterms terms
   special case: if n=0, returns a0
  Examples:
   continued_fraction(func_ai_sqrt2, 3)   # 1 + (1/(2+(1/(2+1/2)))) = 17/12

   func_ai_sqrt13 = make_func_ai_sqrt_N(13)
   continued_fraction(func_ai_sqrt13, 5)        # 119/33

   continued_fraction(func_ai_exp,4)     # 19/7
 =#
 a0 = func_ai(0)
 if nterms == 0
   return a0
 else
  #extra_frac = (BigInt(1), BigInt(func_ai(1)))
  extra_frac = (BigInt(1), BigInt(func_ai(nterms)))
  #for i=2:nterms
  for i=nterms-1:-1:1
   extra_frac = (BigInt(extra_frac[2]), BigInt(func_ai(i)*extra_frac[2] + extra_frac[1]))
  end
  output = reduced_fraction( a0 * extra_frac[2] + extra_frac[1], extra_frac[2] )
  #output = ( a0 * extra_frac[2] + extra_frac[1], extra_frac[2] )
  return output   # (numerator, denominator)
 end
end






function expand_frac(frac)
 # frac is a tuple of integers (numerator, denominator )
 newfrac= (BigInt(2)*frac[2] + frac[1], frac[2])
 return (newfrac[2], newfrac[1])
end

function root2_approx(iterations)
 frac = (BigInt(1),BigInt(2))
 for i = 1:iterations-1
  frac = expand_frac(frac)
 end
 frac = (frac[2] + frac[1], frac[2])
 #return reduced_fraction(frac[1], frac[2])   # numerator, denominator
 return (frac[1], frac[2])   # numerator, denominator
end






function cfrac_sqrt_N_coeffs(N::Int)
    #=
    calculate the coeffients [1, (a_1, a_2, ... )] 

    Approach: the step-by-step process outlined in the Project Euler problem 64 leads to terms of the form:
    a_n + R, where the remainder R can be written in the form
    W/(sqrt(N)-a_n) = a_(n+1) + (sqrt(N) - Y) / Z = a_(n+1) + R1
    
    So the new remainder R1 can be used to calculate a_(n+2), and so on for all a_n
    just need to encode the algebraic steps, reduce fractions, etc. to calculate all the a_n terms
    Finally, need to search for loops. These can be found if the same exact numbers a_n, R appear again.

    OUTPUTS:
    Final result will be an array of two arrays: [[n1, n2, ...], [r1, r2, r3, ...]],
    where the ns are the first (non-repeating) terms, and the rs are the repeating terms of the expansion

    Note: function will break if N is a square. Use is_square in utils/is.jl to check.
    =#

    #=
        .. some scratch notes I used to help understand the arithmetic:
    a0 = Int(floor(sqrt(N)))    
         Note: sqrt(N) = a0 + sqrt(N) - a0                --> form last two terms as 1/...
                       = a0 + 1 / (1/ (sqrt(N) - a0))     --> multiply numerator and denominator of inner fraction by sqrt(N) + a0
                       = a0 + 1 / ( (sqrt(N) + a0)/(N - a0^2) )     --> multiply numerator and denominator of inner fraction by sqrt(N) + a0
                    a1 = Int(floor((sqrt(N) + X)/(N - X^2)))
                    Z = N - a0^2,  Y = a0 - Z
                    R = (sqrt(N) - Y) / Z
               sqrt(N) = a0 + 1 / ( a1 + R )          --> simplify this thingy to find the integer part a1 and a new R to analyze
    =#

    function next_terms(X, W, N)
        # given X, W, calculate the terms a_(n+1), Y, Z as described below
        a_n1 = Int(floor(W*(sqrt(N) + X)/(N - X^2)))
            #intermediate form: R =  W*(sqrt(N) + X) / (N - X^2)
        n, d = reduced_fraction(W, N-X^2)
        Z = d
        rat = (N- X^2) / Z
        Y = Int(floor(W * X / rat - a_n1 * Z))
            # a_n1 + 1/R = a_n1 + (sqrt(N)-Y) / Z ---> Z = next W, -Y = next X
            # a bit hard to follow, but this is just systematizing the fraction arithmetic in the problem (#64)
        return a_n1, Y, Z
    end

    a_n = Int(floor(sqrt(N)))
    X = a_n 
    W = 1
    i = 1
    isloop = false
    inputs = [[X,W,N]]
    as = [[a_n], []]
    #for i = 1:10
    while isloop == false
        i += 1
        a_n, Y, Z = next_terms(X, W, N)
        W = Z
        X = -Y
        push!(as[2], a_n)
        f = findall(x -> x==[X,W,N], inputs)  # look for loops
        if length(f) == 1
            #print(inputs, '\n')
            #print([X, W, N], "this \n")
            # found a repeat
            looplength = i - f[length(f)] + 1
            #print("loop has length $looplength \n")
            isloop = true
            #print("$as \n")     # see outputs/p064.txt
            return as                        # if a loop is found, return the coefficients a_n
        else
            # append the inputs
            push!(inputs, [X, W, N])
        end
        #print("a_n, Y, Z = $a_n , $Y , $Z , \n")
        #print("a_n = $a_n  \n")
    end
end
