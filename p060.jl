#=


Prime pair sets

Problem 60

The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

---------

Approach:

This is basically just a version of the k-clique problem, i.e. finding a
complete subgraph of size k (k=5 here). "complete" means that all vertices are
connected to each other.

https://iq.opengenus.org/algorithm-to-find-cliques-of-a-given-size-k/

My implementation below is very general but not at all optimized.
Optimizations could include:
 use a 2D array lookup table of edges (currently a set of sets, which has slow lookup time)
 sort arrays by value? 
=#


include("utils/prime_factorization.jl")
include("utils/primes.jl")


ps = primes(1, 15000)

# find the graph edges (pairs of primes that concatenate to primes).

edges = []
for p1 in ps
    for p2 in ps 
        if isprime(parse(Int, join([string(p1), string(p2)]))) & isprime(parse(Int, join([string(p2), string(p1)])))
            push!(edges, Set([p1, p2]))
        end
    end
end
edges = Set(edges)   # using sets is easier than arrays here

# find the higher order k-cliques iteratively (3-cliques, 4-cliques, etc.)

k=2
cliques = deepcopy(edges)   # edges are just the 2-cliques

while k<5
    newcliques = []

    for c1 in cliques
        for c2 in cliques
            sd = symdiff(c1,c2)
            if length(sd) == 2
                edge = sd
                if edge ∈  edges
                    push!(newcliques, union(c1, c2))
                end
            end
        end
    end

    k+=1
    cliques = Set(newcliques)
end

answer = mapreduce(sum, min,cliques)
println( The lowest sum for a set of five primes for which any two primes concatenate to produce another prime is:  $answer)

