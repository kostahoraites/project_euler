#=
Powerful digit counts

Problem 63

The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?
=#


#=
Clearly, for a number m^n (where m and n are positive integers) to be an n-digit number, we must have 0<m<10.

And if there exists an n for which no value of m^n is an nth power (not even m=9), then this is also the case for every integer n'>n

so we only need to search until we find such an n (guess an nmax that is sufficiently large)
=#

nmax = 1000
count = 0
nums = []

for n=1:nmax
    for m=1:9
        num = BigInt(m)^BigInt(n)
        if length(string(num)) == n
            push!(nums, num)
            println("$num is a $n th power")
        end
    end 
end
# turns out n=21 is the largest power for which there exists an m^n that is an nth power

answer = length(nums) 
println("There are $answer n-digit positive integers exist which are also an nth power.")



