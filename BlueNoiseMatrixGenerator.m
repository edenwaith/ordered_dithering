/*
 *	BlueNoiseMatrixGenerator.m
 *
 *	Description: Convert an image to a black and white image and use ordered dithering
 * 	Author: Chad Armstrong (chad@edenwaith.com)
 *	Date: 22 March 2026
 *	To compile: gcc -w -framework Foundation -framework Foundation BlueNoiseMatrixGenerator.m -o BlueNoiseMatrixGenerator
 *	To run: ./BlueNoiseMatrixGenerator 
 *
 */

#import <Foundation/Foundation.h>
#import <math.h>

@interface BlueNoiseGenerator : NSObject
@property (nonatomic, assign) int size;
@property (nonatomic, strong) NSMutableArray *matrix;
@end

@implementation BlueNoiseGenerator

- (instancetype)initWithSize:(int)size {
    self = [super init];
    if (self) {
        _size = size;
        // Initialize matrix with -1 (empty)
        _matrix = [NSMutableArray arrayWithCapacity:size * size];
        for (int i = 0; i < size * size; i++) {
            [_matrix addObject:@-1];
        }
    }
    return self;
}

// Calculate distance with wrap-around (toroidal) logic
- (float)toroidalDistanceSquaredFromX1:(int)x1 y1:(int)y1 toX2:(int)x2 y2:(int)y2 {
    float dx = abs(x1 - x2);
    float dy = abs(x1 - x2);
    
    if (dx > _size / 2.0) dx = _size - dx;
    if (dy > _size / 2.0) dy = _size - dy;
    
    return dx*dx + dy*dy;
}

- (void)generate {
    int totalCells = _size * _size;
    float sigma = 1.5; // Influence radius of the "force"
    
    // 1. Reset matrix to -1 (empty)
    for (int i = 0; i < totalCells; i++) {
        _matrix[i] = @-1;
    }

    // 2. Place the seed (Value 0) at a random global location
    int startX = arc4random_uniform(_size);
    int startY = arc4random_uniform(_size);
    _matrix[startY * _size + startX] = @0;

    // 3. Populate values 1 through 63 globally
    for (int v = 1; v < totalCells; v++) {
        float minPotential = INFINITY;
        int bestX = -1;
        int  bestY = -1;

        // GLOBAL SEARCH: Check every single cell in the grid
        for (int y = 0; y < _size; y++) {
            for (int x = 0; x < _size; x++) {
                
                // Only consider empty slots
                if ([_matrix[y * _size + x] intValue] != -1) continue;

                float currentPotential = 0;

                // Calculate total repulsive force from ALL currently placed values
                for (int py = 0; py < _size; py++) {
                    for (int px = 0; px < _size; px++) {
                        int placedValue = [_matrix[py * _size + px] intValue];
                        
                        if (placedValue != -1) {
                            float d2 = [self toroidalDistanceSquaredFromX1:x y1:y toX2:px y2:py];
                            // Gaussian repulsion formula
                            currentPotential += exp(-d2 / (2 * sigma * sigma));
                        }
                    }
                }

                // Identify the globally "loneliest" cell
                if (currentPotential < minPotential) {
                    minPotential = currentPotential;
                    bestX = x;
                    bestY = y;
                }
            }
        }

        // 4. Place the value in the globally optimal spot
        if (bestX != -1 && bestY != -1) {
            _matrix[bestY * _size + bestX] = @(v);
        }
    }
}

- (void)generateOld {
    int totalCells = _size * _size;
    float sigma = 1.5; // Controls the "reach" of the repulsion
    
    // 1. Place the first value at a random seed location
    int currentX = arc4random_uniform(_size);
    int currentY = arc4random_uniform(_size);
    _matrix[currentY * _size + currentX] = @0;

    // 2. Iteratively fill the rest (1 to 63)
    for (int v = 1; v < totalCells; v++) {
        float minPotential = INFINITY;
        int bestX = 0, bestY = 0;

        // Search every empty cell for the one with the lowest potential
        for (int y = 0; y < _size; y++) {
            for (int x = 0; x < _size; x++) {
                if ([_matrix[y * _size + x] intValue] != -1) continue;

                float potential = 0;
                // Sum forces from all already-placed values
                for (int py = 0; py < _size; py++) {
                    for (int px = 0; px < _size; px++) {
                        if ([_matrix[py * _size + px] intValue] != -1) {
                            float d2 = [self toroidalDistanceSquaredFromX1:x y1:y toX2:px y2:py];
                            potential += exp(-d2 / (2 * sigma * sigma));
                        }
                    }
                }

                if (potential < minPotential) {
                    minPotential = potential;
                    bestX = x;
                    bestY = y;
                }
            }
        }
        _matrix[bestY * _size + bestX] = @(v);
    }
}

- (void)printMatrix {
    for (int y = 0; y < _size; y++) {
        NSMutableString *row = [NSMutableString string];
        for (int x = 0; x < _size; x++) {
            [row appendFormat:@"%3d ", [_matrix[y * _size + x] intValue]];
        }
        NSLog(@"%@", row);
    }
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BlueNoiseGenerator *gen = [[BlueNoiseGenerator alloc] initWithSize:8];
        [gen generate];
        [gen printMatrix];
    }
    return 0;
}