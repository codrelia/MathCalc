import Foundation

class Matrix {
    var oneMatrix: [[Double]]
    
    enum error: Error {
        case MismatchOfDimensions
        case MismatchOfColumnsAndRows
        case NotASquareMatrix
        case DegreeIsNotANaturalNumber
    }
    
    init(_ oneMatrix: [[Double]]) {
        self.oneMatrix = oneMatrix
    }
    
    func sum(_ matrix: Matrix) throws -> [[Double]] {
        let twoMatrix = matrix.oneMatrix
        guard oneMatrix.count == twoMatrix.count && oneMatrix[0].count == twoMatrix[0].count else {
            throw error.MismatchOfDimensions
        }
        var resultMatrix: [[Double]] = []
        for i in 0..<oneMatrix.count {
            var oneLine: [Double] = []
            for j in 0..<twoMatrix[i].count {
                oneLine.append(oneMatrix[i][j] + twoMatrix[i][j])
            }
            resultMatrix.append(oneLine)
        }
        return resultMatrix
    }
    
    func difference(_ matrix: Matrix) throws -> [[Double]] {
        let twoMatrix = matrix.oneMatrix
        guard oneMatrix.count == twoMatrix.count && oneMatrix[0].count == twoMatrix[0].count else {
            throw error.MismatchOfDimensions
        }
        var resultMatrix: [[Double]] = []
        for i in 0..<oneMatrix.count {
            var oneLine: [Double] = []
            for j in 0..<twoMatrix[i].count {
                oneLine.append(oneMatrix[i][j] - twoMatrix[i][j])
            }
            resultMatrix.append(oneLine)
        }
        return resultMatrix
    }
    
    func multiplication(_ matrix: Matrix) throws -> [[Double]] {
        let twoMatrix = matrix.oneMatrix
        guard oneMatrix[0].count == twoMatrix.count else {
            throw error.MismatchOfColumnsAndRows
        }
        var resultMatrix: [[Double]] = []
        for i in 0..<oneMatrix.count {
            var oneLine: [Double] = []
            for k in 0..<twoMatrix[0].count {
                var sum: Double = 0
                for j in 0..<twoMatrix.count {
                    sum += oneMatrix[i][j] * twoMatrix[j][k]
                }
                oneLine.append(sum)
            }

            resultMatrix.append(oneLine)
        }
        return resultMatrix
    }
    
    func multiplicationByANumber(_ number: Double) -> [[Double]]  {
        var resultMatrix: [[Double]] = []
        for i in 0..<oneMatrix.count {
            var oneLine: [Double] = []
            for j in 0..<oneMatrix[i].count {
                oneLine.append(oneMatrix[i][j] * number)
            }
            resultMatrix.append(oneLine)
        }
        return resultMatrix
    }
    
    func determinant() throws -> Double {
        guard oneMatrix[0].count == oneMatrix.count else {
            throw error.NotASquareMatrix
        }
        var determinant: Double = 0
        if oneMatrix.count == 2 {
            return oneMatrix[0][0] * oneMatrix[1][1] - oneMatrix[0][1] * oneMatrix[1][0]
        }
        let i: Int = 0
        for j in 0..<oneMatrix[i].count {
            let isolatedArray = Matrix(matrixExtraction(i, j, oneMatrix.count))
            determinant += pow(-1.0, Double((i + j))) * oneMatrix[i][j] * (try! isolatedArray.determinant())
        }
        return determinant
    }
    
    private func matrixExtraction(_ i1: Int, _ j1: Int, _ size: Int) -> [[Double]] {
        var resultMatrix: [[Double]] = []
        for i in 0..<size {
            var oneLine: [Double] = []
            for j in 0..<size {
                if (i != i1 && j != j1 ) {
                    oneLine.append(oneMatrix[i][j])
                }
            }
            if oneLine != [] {
                resultMatrix.append(oneLine)
            }
        }
        return resultMatrix
    }
    
    func transposition() -> [[Double]] {
        var resultMatrix: [[Double]] = []
        for i in 0..<oneMatrix[0].count {
            var oneLine: [Double] = []
            for j in 0..<oneMatrix.count  {
                oneLine.append(oneMatrix[j][i])
            }
            resultMatrix.append(oneLine)
        }
        return resultMatrix
    }
    
    func rank() -> Int {
        var resultMatrix = self.oneMatrix
        var result: Int = min(resultMatrix.count, resultMatrix[0].count)
        var row: Int = 0
        while row < result {
            if resultMatrix[row][row] != 0 {
                for col in 0..<resultMatrix.count {
                    if col != row {
                        let mult = resultMatrix[col][row] / resultMatrix[row][row]
                        for i in 0..<result {
                            resultMatrix[col][i] -= mult * resultMatrix[row][i]
                        }
                    }
                }
                row += 1
            }
            else {
                var reduce: Bool = true
                for i in (row + 1)..<resultMatrix.count {
                    if resultMatrix[i][row] != 0 {
                        resultMatrix = swapOfLine(resultMatrix, row, i, result)
                        reduce = false;
                        break;
                    }
                }
                if reduce {
                    result -= 1
                    for i in 0..<resultMatrix.count {
                        resultMatrix[i][row] = resultMatrix[i][result]
                    }
                }
            }
        }
        return result
    }
    
    private func swapOfLine(_ matrix: [[Double]], _ i1: Int, _ i2: Int, _ j1: Int) -> [[Double]] {
        var resultMatrix: [[Double]] = matrix
        for i in 0..<j1 {
            let temp = resultMatrix[i1][i]
            resultMatrix[i1][i] = resultMatrix[i2][i]
            resultMatrix[i2][i] = temp
        }
        return resultMatrix
    }
    
    func trace() throws -> Double {
        guard oneMatrix[0].count == oneMatrix.count else {
            throw error.NotASquareMatrix
        }
        var trace: Double = 0
        for i in 0..<oneMatrix.count {
            trace += oneMatrix[i][i]
        }
        return trace
    }
    
    func raiseToADegree(_ degree: Int) throws -> [[Double]] {
        guard oneMatrix[0].count == oneMatrix.count else {
            throw error.NotASquareMatrix
        }
        guard degree >= 0 else {
            throw error.DegreeIsNotANaturalNumber
        }
        var resultMatrix: [[Double]] = oneMatrix
        if degree == 0 {
            for i in 0..<oneMatrix.count {
                for j in 0..<oneMatrix.count {
                    if i == j {
                        resultMatrix[i][j] = 1
                    }
                    else {
                        resultMatrix[i][j] = 0
                    }
                }
            }
        }
        else {
            for _ in 1..<degree {
                resultMatrix = try! Matrix(resultMatrix).multiplication(Matrix(oneMatrix))
            }
        }
        return resultMatrix
    }
    
    func inverseMatrix() throws -> [[Double]] {
        guard oneMatrix[0].count == oneMatrix.count else {
            throw error.NotASquareMatrix
        }
        var resultMatrix: [[Double]] = oneMatrix
        let det: Double = try! determinant()
        for i in 0..<oneMatrix.count {
            for j in 0..<oneMatrix.count {
                resultMatrix[j][i] = pow(-1.0, Double(i + j)) * (try! Matrix(matrixExtraction(i, j, oneMatrix.count)).determinant())
            }
        }
        resultMatrix = Matrix(resultMatrix).multiplicationByANumber(det)
        return resultMatrix
    }
    
}

