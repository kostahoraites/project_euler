/* 
    compile with:       g++ -std=c++0x p074.cpp -o p074
    run with:           ./p074

Digit Factorial Chains
Problem 74

The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:
Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169;
    it turns out that there are only three such loops that exist:

169 -> 363601 -> 1454 -> 169
...

It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,

...

Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.

How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?

*/

#include <iostream>  // std::cout
#include <cstdio>  // printf


int factorial (int n)
{
    int output = 1;
    for (int i=1; i<=n; i++)
    {
    output *= i;
    }
    return output;
} 


int digfactsum (int n)
{
    int output = 0;
    int lastdig;
    while (n > 0)
    {
        lastdig = n - 10*(n/10);
        //std::cout << lastdig;
        output += factorial(lastdig);
        n = n/10;  // note: n was passed by value
    }
    return output;
}


int n_occur (int array[61], int num){ // count number of occurrences of num in the input array
    int count = 0;
    for (int i=0; i<61; i++) {
        if (array[i]==num)
            count++ ;
    }
    return count;
}


// work-in-progress
int digfactchain (int n)
{
    int n_array[61] = {0};  // Problem states that no chain should have more than 60 non-repeating terms, initialize as zeros
    int currentlink = n;
    int output = 0;
    for (int i=0; i<61; i++) {
        output += 1;
        n_array[i] = currentlink;
        //printf("%d \n", currentlink);
        if (n_occur(n_array, currentlink) == 2)   // see if there are two occurrences of the same number (i.e. a loop)
            return output-1;
        currentlink = digfactsum(currentlink);
    }
    return output-1;
}




int facts [10];
int main()
{
    for (int i=0; i<10; i++)
    {
    facts[i] = factorial(i);        // compute these ahead of time so they don't need to be re-computed
    std::cout << facts[i] << ", ";
    }
    //std::cout << "\n";
    //std::cout << digfactsum(145);
    //std::cout << digfactchain(69);
    int answer = 0;
    for (int n=1; n<1000000; n++)
    {
        printf("%d \n", n);
        if (digfactchain(n) == 60)
            answer++;
        
    }
    printf("%d chains, with a starting number below one million, contain exactly sixty non-repeating terms", answer);
}

