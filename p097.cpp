/*
compile with:       g++ -std=c++0x p092.cpp -o p097
run with:           ./p097

Large Non-Mersenne Prime

Problem 97

The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form
2^6972593 - 1; it contains exactly 2098960 digits. Subsequently other Mersenne primes, of the form 2^p - 1, have been found which contain more digits.

However, in 2004 there was found a massive non-Mersenne prime which contains 2357207 digits:
28433 * 2^7830457 + 1.

Find the last ten digits of this prime number.
*/

#include <cstdio> // printf()
#include <limits>


long long mult_10 (long long num1, long long num2) { // long long is 64 bit int
    return (num1 * num2) % 10000000000LL;  // multiply num1 and num2 and keep the smallest 10 digits
}

int main () {
    long long answer = 28433LL;
    for (long n=1; n<=7830457; n++) {
        //printf(" %lld \n", answer);  // lld for 'long long'
        answer = mult_10(answer, 2LL);
    }
    answer += 1LL;
    printf("The last ten digits of this large prime number are %lld \n", answer);  // lld for 'long long'
    //printf("max int %lld \n", std::numeric_limits<long long>::max());  // lld for 'long long'
}


