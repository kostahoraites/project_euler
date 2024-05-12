/*

compile with:       g++ -std=c++0x p092.cpp -o p092
run with:           ./p092

Square Digit Chains

Problem 92

A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

For example,

44 -> 32 -> 13 -> 10 -> 1 -> 1
85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89
Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?
*/


/*
 *I use a brute force algorithm here. But could potentially speed up by recording every number visited in all chains and where that 
 chain ends up. Then whenever a new number is reached could check if it has been used before (dynamic programming).
 */

#include <string> // for string and to_string()
#include <cmath>  // pow()
#include <cstdio> // printf()


int nextnum(int n)
{
    //printf("%d \n", n);
    std::string nstr = std::to_string(n);
    int nchar = nstr.size();
    int charnum;
    int output=0;
    for (int i=0; i<nchar; i++)
    {
        charnum = nstr[i] - '0';    // (hack to convert characters to corresponding ints) https://sentry.io/answers/char-to-int-in-c-and-cpp/
        //printf("%d \n", charnum);
        output += pow(charnum, 2);
    }
    //printf("output %d \n", output);
    return output;
}


int main()
{
    int currentnum;
    int answer = 0;
    for (int n=1; n<10000000; n++)
    {
        //printf("%d \n", n);
        currentnum = n;
        while (currentnum != 1 & currentnum != 89)
        {
            //printf("%d ", currentnum);
            currentnum = nextnum(currentnum);
        }
        if (currentnum == 89)
            answer += 1;
    }
    printf("%d starting numbers below ten million will arrive at 89 \n", answer);
}

