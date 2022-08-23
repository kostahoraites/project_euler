
#EULER HAS A METHOD FOR SOLVING DIOPHANTINE EQUATIONS: see e.g. https://math.stackexchange.com/questions/3051166/eulers-method-for-linear-diophantine-equations

#=
Arranged probability

Problem 100

If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)×(14/20) = 1/2.

The next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box containing eighty-five blue discs and thirty-five red discs.

By finding the first arrangement to contain over 10^12 = 1,000,000,000,000 discs in total, determine the number of blue discs that the box would contain.
=#

#=
note the condition for 1/2 probability satisfies the formula:

b *(b-1) / (n * (n-1)) = 1/2

where r=# red discs, b=#blue discs, n=b+r


rearrange: b^2 -b -C = 0, where C(n)= (1/2) * (n^2 -n)
For a given n, can solve for b from the quadratic equation:

b = (1 +/- sqrt(1 + 4 *C(n)) ) / 2

except in the case n=1, only need to consider the + solution (avoid square root of negative number)

b = b(n) = (1 + sqrt(1 + 4 *C(n)) ) / 2

take the derivative wrt n

db/dn = C'(n) / sqrt(1 + 4* C(n))

where C'(n) = dC/dn = n - 1/2

similarly:
db^2/dn^2 = 1 / sqrt(1 + 4* C(n)) - 2* (C'(n))^2 / (1 + 4* C(n))^(3/2)

(note: C''(n) =  1)
=#

b = 51.50 
dbdn = 0.003

3 * deltan = 1.38
3*deltan - floor(3*deltan) = 0.38    # cycles of 3
 ceil(1/ C1) = 3
3*C1 - floor(3*C1) = 0.14 = C2           # cycles of 3*3=9  
 ceil(1/ C2) = 8
8*C2 - floor(8*C2) = 0.12 = C3           #cycles of 9*8 = 72



b = 51.7

diff = ceil(b) - b
db = 0.47
dn = 1
db_dec = db - floor(db)   # = 0.46
while diff < db_dec    # 0.3 < 0.46
 print("yo")
 a = BigInt(ceil(1 / db_dec))         # = 3
  #print("a=$a \n")
 dn = a * dn                # = 3
  #print("db=$dn \n")
 db = a * db               # = 1.38
  #print("db=$db \n")
 db_dec = db - floor(db)   # = 0.38    # cycles of 3
  #print("db_dec=$db_dec \n")
end

b +=db
print(b)
print(db)

ceil(1/ C1) = 3
 3*C1 - floor(3*C1) = 0.14 = C2           # cycles of 3*3=9  
  ceil(1/ C2) = 8
 8*C2 - floor(8*C2) = 0.12 = C3           #cycles of 9*8 = 72

dbdn = 0.42
dn = 1
db = = dn * dbdn

a = ceil(1 / db)
dn = a*dn
db = dn * dbdn
c = a*db - floor(a*db)



b = BigFloat(51.0)
dbdn = BigFloat(0.00324859)
db2dn2 = BigFloat(0.0000001)
dn = BigFloat(2)
diff = BigFloat(ceil(b) - b )     # 0.3



#check if 1st and 2nd-order Taylor approximation predicts different rounded numbers
acc_factor = 10 # exaggerate the influence of the 2nd order term, just to be safe
b_taylor_1 = b + dbdn * dn                         # first order Taylor approx.
b_taylor_2 = b + dbdn * dn +acc_factor * 0.5 * db2dn2 * dn^2   # second order Taylor approx.

tol_factor =10
tol = tol_factor * 0.5 * db2dn2 * dn^2

#if floor(b_taylor_1) != floor(b_taylor_2)
if abs((b+dbdn * dn) - round(b + dbdn*dn)) < abs(tol)
   b = b + db*dn
   dn = 1
   print("b = $b, n=$n \n")
   #stop iterating
else
 db = dbdn*dn                       #0.4
 db_dec = db - floor(db)            #0.4,     decimal part of db
 dn_factor_high = ceil( (1 / db_dec)  )  #1
 if diff < db_dec
  dn_factor_high = ceil( (diff / db_dec)  )  #1
 else
  dn_factor_high = ceil( ( db_dec / diff)  )  #1
 end
 print("!!!db_dec = $db_dec \n")
 if dn_factor_high < 3
  dn_factor_high = 3     #3
 end
 dn_factor_low = dn_factor_high - 1 #2

 if db2dn2 <0
  dn = dn*dn_factor_high
 else
  dn = dn* dn_factor_low
 end
 print("dn= $dn")
end


if db > diff
 dnfactor = 1/db

deltan = 1
deltan*dbdn = 



N*0.46 = M+ 0.30
--> 46* N = 100*M + 30


b = 54.0
dbdn = 0.0013
dn = 1
dn_trial = dn
tol_factor =10
tol = tol_factor * 0.5 * db2dn2 * dn^2





for i=1:100000
diff = BigFloat(ceil(b) - b )     # 0.3
db = dbdn * dn
db_dec = db - floor(db)            #0.4,     decimal part of db

if diff==0
 dn = 1
 b = b + db
else
 if diff >= db_dec
  b = b + db
  n = n + dn
 else
  

#=
  dn_trial +=1
  db_trial = dbdn * dn_trial
  db_dec_trial = db_trial - floor(db_trial)            #0.4,     decimal part of db
  if db_dec_trial < db_dec
   dn = dn_trial
   db = dbdn * dn
   db_dec = db_dec_trial
   print("db_dec = $db_dec\n")
   print("b = $b\n")
=#
  end
 end
end

b = b + db

end

function find_nstep(n, b, dbdn, db2dbn2)
    # determine how large of a timestep delta to take by approximating b(n+deltan) with the Taylor series
    # start with a small timestep (deltan = 1) then see how large this can be increased
    # if truncating the series to b'(n) and b''(n) give the same projected b(n+deltan) then 
    # if factoring in the second derivative b''(n) causes the 


    return deltan
end




#for n=convert(BigInt, 1000000000000):convert(BigInt, 1000100000000)
for n=convert(BigInt, 1):convert(BigInt, 1000)
    # find number of blue discs b    
    C= (1/2) * (n^2 -n)
    b =  (1 + sqrt(1 + 4*C) ) / 2
    if b == floor(b)
      r = n-b
      print("    blue = $b, red = $r, ndiscs = $n\n\n")
    end
    # consider b - floor(b)
    diffb = b - floor(b)
    print("b - floor(b) = $diffb \n")
    # consider db/dn, which is very stable between iterations. approximate db/dn as a rational number,
    # and estimate how many iterations until the next n s.t. b(n) is a whole number
    dCdn = n - 0.5
    dbdn = dCdn / sqrt(1 + 4*C)
    print("db/dn = $dbdn \n")
    db2dn2 = 1 / sqrt(1 + 4* C) - 2* (dCdn)^2 / (1 + 4* C)^(1.5)
    print("d^2b/dn^2 = $db2dn2 \n")
end



