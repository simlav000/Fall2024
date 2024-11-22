#include <stdio.h>

// Function to count trailing zeros
int countTrailingZeros(int num) {
    int count = 0;
    while ((num & 1) == 0) {
        count++;
        num >>= 1;
    }
    return count;
}

// Function to perform Tower of Hanoi using direct computation
void hanoiMoves(int numDisks) {
    int totalMoves = (1 << numDisks) - 1;  // Total moves: 2^n - 1
    for (int m = 1; m <= totalMoves; m++) {
        int disk = countTrailingZeros(m);
        int source = (m & (m - 1)) % 3;
        int destination = ((m | (m - 1)) + 1) % 3;
        
        printf("Step %d: move disk %d from peg %d to peg %d\n", m, disk, source, destination);
    }
}

int main() {
    int numDisks = 3; // Example with 3 disks
    hanoiMoves(numDisks);
    return 0;
}
