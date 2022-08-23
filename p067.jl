#=
Problem 67

By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file containing a triangle with one-hundred rows.

NOTE: This is a much more difficult version of Problem 18. It is not possible to try every route to solve this problem, as there are 299 altogether! If you could check one trillion (1012) routes every second it would take over twenty billion years to check them all. There is an efficient algorithm to solve it. ;o)

=#



function parse_numbers(s)
    pieces = split(s, ' ', keepempty=false)
    map(pieces) do piece
        parse(Int64, piece)
    end
end


nums = []

open("data/p067_triangle.txt") do f
    for (i, line) in enumerate(eachline(f))
        push!(nums, parse_numbers(line))
    end
end

# nums is a 2D array, where nums[i][j] specifies the jth element of the ith row (1, 2, 3, ...)

# notice: each element of the tree has 2 (or 1) parents. each of those parents has some maximal sum that comes from descending in the tree in the same manner. So any given elements maximal sum is just its own value plus the larger value between the maximal sum of its different parents.
# technique: starting from the top, descend the tree and compute the maximal sum for each element, by checking the already-computed maximal sums of the element's parents.

max_sums = nums*0   # keep track of the maximal sums
nrows = length(nums)

for i=1:nrows
 for j=1:i
  if i==1
   max_sums[i][j] = nums[i][j]
  elseif j==1
   max_sums[i][j] = nums[i][j] + max_sums[i-1][1]
  elseif j==i
   max_sums[i][j] = nums[i][j] + max_sums[i-1][j-1]
  else
   max_sums[i][j] = nums[i][j] + max(max_sums[i-1][j-1], max_sums[i-1][j])
  end
 end
end

solution = maximum(max_sums[nrows])
print("the maximum path sum is:\n $solution \n")



