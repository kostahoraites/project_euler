# given a list of elements (each element may itself be a list of identical items), make a list of all the permutations

#Approach: account for all the permutations in a tree structure
#each node of the tree, at depth n, keeps track of the first n elements of the permutation, as well as an array of remaining elements from which the next element in the permuation will be chosen
#the final leaves of the tree, at depth N will each represent a complete permutation with N elements (0 remaining)

#Example: println(permutations([[2,2,2],3,[1,1]]))

using Multisets

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
    #if length(inputs) != length(unique(inputs))
    #    println("All elements of inputs must be unique (or specify multiplicities in 2nd argument)")
    #    return
    #end
    M = Multiset(inputs)
    multiplicities = collect(values(M))
    inputs = collect(keys(M))
    root = Node([], [], inputs, multiplicities)
    grow_tree!(root);
    return(get_leaves(root))
end


function permutations(inputs::Array)
    s = length(inputs)
    multiplicities = ones(Int, s)
    return permutations(inputs, multiplicities)
end


##### OTHER ROUTINES


function ispermutation(arr1::Array, arr2::Array)
  #running time is somewhere between O(n) best case when strings are the same
  # and O(l^2) worst case, when strings are perfectly out of order
  #optimization: for large arrays of sortable quantities, may want to sort the array first

 if length(arr1) != length(arr2)
  return false
 else  # arr1 == arr2
  l = length(arr1)
  ind = 1
  checked = zeros(Int, l)
  for i=1:l
   j = 1
   found = false
   while (j<=l) & (found == false)  # check through one full rotation
    if (arr1[i] == arr2[ind]) & (checked[ind] != 1)
     a1 = arr1[i]
     a2 = arr2[ind]
     found = true
    checked[ind] = 1
    end
    j += 1
    ind = (ind % l) + 1  # increment ind and loop back to ind=1 if necessary
   end
   if found == false
    return false  # no matches found in 1 rotation
   end
  end
  return true    # all members were found
  end
end

 



