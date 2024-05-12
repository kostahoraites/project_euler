/*
    compile with:       g++ -std=c++0x p085.cpp -o p085
    run with:           ./p085

   
Counting Rectangles

Problem 85

By counting carefully it can be seen that a rectangular grid measuring 3 by 2
contains eighteen rectangles:

one 1x1 rectangle, one 3x2, two 3x1, etc. fit into 3x2

Although there exists no rectangular grid that contains exactly two million rectangles, find the area of the grid with the nearest solution.
*/

/*
Approach: write a function that calculates explicitly the number of rectangles of different dimensions that fit inside.
LOOP -- Start with dimensions of the outer rectangle and expand the dimensions +1 in length or width.
    calculations will involve sums of the form 1+2+3+4... so use triangle numbers instead of for loops?
 */

#include <iostream>  // std::cout
#include <cstdio>  // printf
#include <cstdlib>  // abs


/*
int nrec(int w, int h) // SLOW WAY: nrec computes the number of rectangles that fit into a (w x h) rectangle
{
    int output = 0;
    for (int w2=1; w2<=w; w2++) {
        for (int h2=1; h2<=h; h2++) {
            output += (w-w2+1)*(h-h2+1);
        }
    }
    return output; 
}
*/


int nrec(int w, int h) // FAST WAY: nrec computes the number of rectangles that fit into a (w x h) rectangle
                        // This works by collapsing the two for loops in the SLOW implementation above into triangle numbers
{
    return (w*(w+1)/2)*(h*(h+1))/2;
}


int main()
{
    int target = 2000000;
    int answer = 0;
    int diff = 2000000;
    int n = 0;
    for (int w=1; w<=2000; w++) {
        for (int h=1; h<=2000; h++) { // don't need to search higher than 2000 in either rectangle dimension. bc if one dimension is >=2000 then total # of rectangles is > 2 million
            n = nrec(w, h);
            if (abs(target - n) < diff)
            {
                answer = w*h;
                diff = abs(target - n);
                //printf("%d \n", n);
            }
        } 
    } 
    printf("%d \n", answer);
    return 0;
}
