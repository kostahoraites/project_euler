# given a list of elements (each element may itself be a list of identical items), make a list of all the permutations

#account for all the permutations in a tree structure
#each node of the tree, at depth n, keeps track of the first n elements of the permutation, as well as an array of remaining elements from which the next element in the permuation will be chosen
#the final leaves of the tree, at depth N will each represent a complete permutation with N elements (0 remaining)


mutable struct Node
    children::Array    # an array of the nodes children
    firstn::Array      # first n elements of the permutation, an array
    remaining::Array   # an array of unique remaining elements
    remaining_mult::Array{Int}    # the remaining multiplicities of remaining array
end

function grow_tree!(thisnode::Node)
    if length(thisnode.remaining) == 0
        return
    else
        #for i in 1:length(thisnode.remaining)
        for i in length(thisnode.remaining):-1:1   # reverse loop is important here because 
                                                   # because the lengths of field arrays in 
                                                   # thisnode will change with each call to add_child
            add_child!(thisnode, i);
        end
        nc = length(thisnode.children)
        for i in 1:nc
            grow_tree!(thisnode.children[i])    # RECURSION
        end
    end
end


function add_child!(thisnode::Node, i)
    newnode = deepcopy(thisnode);
    newnode.children = []
    newnode.remaining_mult[i] -= 1
    push!(newnode.firstn, newnode.remaining[i]);
    if newnode.remaining_mult[i] == 0
        splice!(newnode.remaining, i);
        splice!(newnode.remaining_mult, i);
    end
    push!(thisnode.children, newnode)    # should this be append! instead of push?
end



function get_leaves(thisnode::Node)
#return the leaves as an array of arrays (the subarrays are the value of firstn of the leaves)
    if length(thisnode.children) == 0
        return [thisnode.firstn]
    else
        output = [] 
        for i in 1:length(thisnode.children)
            append!(output, get_leaves(thisnode.children[i]));
        end
        return output
    end
end



function permutations(inputs::Array, multiplicities::Array{Int})
    if length(inputs) != length(unique(inputs))
        println("All elements of inputs must be unique (or specify multiplicities in 2nd argument)")
        return
    end
    root = Node([], [], inputs, multiplicities)
    grow_tree!(root);
    return(get_leaves(root))
end


function permutations(inputs::Array)
    s = length(inputs)
    multiplicities = ones(Int, s)
    return permutations(inputs, multiplicities)
end

