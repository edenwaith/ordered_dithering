/*
# To generate a default 8x8 matrix
swift voidcluster.swift

# To generate a 16x16 matrix
swift voidcluster.swift 16
*/

import Foundation

// --- Core Algorithm Logic ---

func generateVoidAndCluster(size: Int, sigma: Double = 1.5) -> [[Int]] {
    let totalPixels = size * size
    var matrix = Array(repeating: Array(repeating: 0, count: size), count: size)
    var currentDots = Array(repeating: Array(repeating: false, count: size), count: size)
    
    // 1. Initial Seed: Place a single random dot
    let startY = Int.random(in: 0..<size)
    let startX = Int.random(in: 0..<size)
    currentDots[startY][startX] = true
    matrix[startY][startX] = 0
    
    // 2. Iteratively fill the matrix
    for rank in 1..<totalPixels {
        var bestVoidY = -1
        var bestVoidX = -1
        var minDensity = Double.greatestFiniteMagnitude
        
        // Scan for the largest void (lowest density)
        for y in 0..<size {
            for x in 0..<size {
                if currentDots[y][x] { continue }
                
                let density = calculateDensity(y: y, x: x, size: size, dots: currentDots, sigma: sigma)
                
                if density < minDensity {
                    minDensity = density
                    bestVoidY = y
                    bestVoidX = x
                }
            }
        }
        
        currentDots[bestVoidY][bestVoidX] = true
        matrix[bestVoidY][bestVoidX] = rank
    }
    
    return matrix
}

// Toroidal (wrapped) Gaussian density calculation
func calculateDensity(y: Int, x: Int, size: Int, dots: [[Bool]], sigma: Double) -> Double {
    var density = 0.0
    let twoSigmaSq = 2.0 * sigma * sigma
    
    for dy in 0..<size {
        for dx in 0..<size {
            if !dots[dy][dx] { continue }
            
            // Calculate toroidal distance
            var diffY = Double(abs(y - dy))
            if diffY > Double(size) / 2.0 { diffY = Double(size) - diffY }
            
            var diffX = Double(abs(x - dx))
            if diffX > Double(size) / 2.0 { diffX = Double(size) - diffX }
            
            let distSq = diffY * diffY + diffX * diffX
            density += exp(-distSq / twoSigmaSq)
        }
    }
    return density
}

// --- Command Line Interface ---

func main() {
    let arguments = CommandLine.arguments
    var size = 8 // Default size
    
    if arguments.count > 1, let inputSize = Int(arguments[1]) {
        size = inputSize
    }
    
    print("Generating \(size)x\(size) Void-and-Cluster Matrix...")
    let result = generateVoidAndCluster(size: size)
    
    print("\nResulting Blue Noise Matrix:")
    print(String(repeating: "-", count: size * 4))
    for row in result {
        let rowString = "{ " + row.map { String(format: "%3d", $0) }.joined(separator: ", ") + " },"
        print(rowString)
    }
    print(String(repeating: "-", count: size * 4))
}

main()