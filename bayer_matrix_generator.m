/*	bayer_matrix_generator.m
 *
 *	To compile: clang -fobjc-arc -framework Foundation bayer_matrix_generator.m -o bayer_matrix_generator
 *	To run: ./bayer_matrix_generator <matrix_size>
 */
#import <Foundation/Foundation.h>
#include <stdio.h>
#include <math.h>

// Function to calculate the value at (x, y) for a Bayer matrix of size N
int getBayerValueWrong(int x, int y, int size) {
    int value = 0;
    int n = size;
    
    // Use bit manipulation to determine the threshold value
    // based on the recursive definition
    for (int i = size / 2; i > 0; i /= 2) {
        value = (value << 2) | ((x / i) % 2 ^ (y / i) % 2) | (((y / i) % 2) << 1);
    }
    return value;
}

int getBayerValueWrong2(int x, int y, int size) {
    int res = 0;
    // Iterate through the bits from most significant to least significant
    for (int mask = size >> 1; mask > 0; mask >>= 1) {
        // Interleave bits of x and y, but follow the specific Bayer quadrant pattern:
        // Top-Left: 0, Top-Right: 2, Bottom-Left: 3, Bottom-Right: 1
        res = (res << 2) | ((x & mask) ? ((y & mask) ? 1 : 2) : ((y & mask) ? 3 : 0));
    }
    return res;
}

/**
 * Calculates the Bayer matrix value using bit-reversal interleaving.
 * To achieve the proper dispersal, we look at the bits of x and y 
 * from the least significant bit (LSB) to the most significant bit (MSB).
 */
int getBayerValueWrong3(int x, int y, int size) {
    int value = 0;
    int b = 0;
    
    // We iterate through the bits of the coordinates.
    // The LSB of the coordinates determines the MSB of the resulting value.
    for (int mask = 1; mask < size; mask <<= 1) {
        // Bayer Pattern logic for each bit level:
        // x_bit ^ y_bit determines the first bit of the pair
        // y_bit determines the second bit of the pair
        value |= ((x & mask) ^ (y & mask)) << (b + 1) | (y & mask) << b;
        b += 2;
    }
    return value;
}

int getBayerValue(int x, int y, int size) {
    int value = 0;
    int tempX = x;
    int tempY = y;
    
    // Determine how many bits we are dealing with (e.g., 3 bits for size 8)
    int levels = 0;
    for (int s = size; s > 1; s >>= 1) levels++;

    for (int i = 0; i < levels; i++) {
        /*
         The Bayer recursive formula translates to:
         Bit i of X and Y maps to Bit (levels - 1 - i) of the result.
         Specifically: 
         - x_bit ^ y_bit becomes the high bit of the pair
         - y_bit becomes the low bit of the pair
        */
        int xBit = (tempX >> i) & 1;
        int yBit = (tempY >> i) & 1;
        
        int bitPair = ((xBit ^ yBit) << 1) | yBit;
        
        // Shift the pair into the correct position (MSB first)
        value |= (bitPair << (2 * (levels - 1 - i)));
    }
    return value;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            printf("Usage: bayer_gen <size>\n");
            printf("Note: size must be a power of 2 (e.g., 2, 4, 8).\n");
            return 1;
        }

        int n = atoi(argv[1]);

        // Validate that n is a power of 2
        if (n <= 0 || (n & (n - 1)) != 0) {
            printf("Error: Size must be a power of 2 (2, 4, 8, 16...)\n");
            return 1;
        }

        printf("Bayer Ordered Dither Matrix (%dx%d):\n\n", n, n);

        // Generate and print the matrix
        for (int y = 0; y < n; y++) {
        	printf("{ ");
            for (int x = 0; x < n; x++) {
                int value = getBayerValue(x, y, n);
                // Format the output to keep columns aligned
                // printf("%3d ", value);
                printf("%3d%s", getBayerValue(x, y, n), (x == n - 1) ? "" : ", ");
            }
            printf(" },\n");
        }
        printf("\n");
    }
    return 0;
}