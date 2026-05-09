/*  ordered_dithering.c
 *  Code by Stephen Hawley from page 713 from the book Graphics Gems
 *  Generates a dithering matrix from the command line arguments.
 *  The first argument, size, determines the dimensions of the
 *  matrix, 2^size by 2^size
 *  The optional range argument is the range of values to be 
 *  dithered over.  By default, it is (2^size)^2, or simply the
 *  total number of elements in the matrix.
 *  The final output is suitable for inclusion in a C program.
 *  Date: 3 September 2023
 *  To compile: gcc -Wall ordered_dithering.c -o ordered_dithering
 *  To run: ./ordered_dithering [order size of matrix array] [range]
 */
#include <stdio.h>
#include <stdlib.h>

// Prototypes
void printDither(int size, int range);
int ditherValue(int x, int y, int size);

int main(int argc, char * argv[]) {

    int size, range;

    if (argc >= 2) {
        size = atoi(argv[1]);
    } else {
        size = 2;
    }

    if (argc == 3) {
        range = atoi(argv[2]);
    } else {
        range = (1 << size) * (1 << size);
    }

    printDither(size, range);
    return 0;
}

/// @brief 
/// @param size The order size of the matrix
/// @param range The range of the values in the matrix
void printDither(int size, int range) {

    int length = (1 << size); // print a dithering matrix.  length is the length on a side
    int lengthSquared = length * length;
    int i = 0;

    range = range / (lengthSquared); 

    printf("int dm[%d][%d] = {\n", length, length);

    for (i = 0; i < lengthSquared; i++) {
        if (i % length == 0) { 
            // tab in 4 spaces per row
            printf("    { %2d", range * ditherValue(i/length, i%length, size));
        } else {
            // print the dither value for this location
            // scaled to the given range
            printf("%4d", range * ditherValue(i/length, i%length, size));
        }

        // commas after all but the last
        if (i + 1 < lengthSquared) {
            printf(",");
        } else {
            printf(" ");
        }

        // newline at the end of the row
        if ((i + 1) % length == 0) {
            if ((i + 1) == lengthSquared) {
                // Do not add a comma after the last row
                printf(" }\n");
            } else {
                printf(" },\n");
            }
        }
    }

    printf("}; \n");
}

int ditherValue(int x, int y, int size) {
    int d = 0;

    // calculate the dither value at a particular
    // (x, y) over the size of the matrix

    while (size-->0) {
        
        /* Think of d as the density.  At every iteration,
         * d is shifted left one and new bit is put in the 
         * low bit based on x and y.  If x is odd and y is even,
         * or x is even and y is odd, a bit is put in.  This
         * generates the checkerboard seen in dithering.
         * This quantity is shifted left again and the low bit of 
         * y is added in.
         * This whole thing interleaves a checkerboard bit pattern
         * and y's bits, which is the value you want.
         */
        d = (d <<1 | ((x&1) ^ (y&1)))<<1 | (y&1);
        x >>= 1;
        y >>= 1;
    }
    
    return d;
}