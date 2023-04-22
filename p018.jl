#=


By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:

75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)

=#



nums = [[75],
        [95 64],
        [17 47 82],
        [18 35 87 10],
        [20 04 82 47 65],
        [19 01 23 75 03 34],
        [88 02 77 73 07 63 67],
        [99 65 04 28 06 16 70 92],
        [41 41 26 56 83 40 80 70 33],
        [41 48 72 33 47 32 37 16 94 29],
        [53 71 44 65 25 43 91 52 97 51 14],
        [70 11 33 28 77 73 17 78 39 68 17 57],
        [91 71 52 38 17 14 91 43 58 50 27 29 48],
        [63 66 04 68 89 53 67 30 73 16 69 87 40 31],
        [04 62 98 27 23 09 70 98 73 93 38 53 60 04 23]]



#APPROACH: use the same approach as used in problem 67 (implemented that first)

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

