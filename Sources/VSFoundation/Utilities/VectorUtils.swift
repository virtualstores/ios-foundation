// VectorUtils.swift
// VSFoundation

// Created by: CJ on 2021-11-28
// Copyright (c) 2021 Virtual Stores

import Foundation

public class VectorUtils {

  static func dotProduct(vector1: [Double], vector2: [Double]) -> Double {
    return vector1[0] * vector2[0] + vector1[1] * vector2[1] + vector1[2] * vector2[2]
  }

  static func vectorAddition(vector1: [Double], vector2: [Double]) -> [Double] {
    if vector1.count != vector2.count {
      fatalError("Trying to add vectors of different lengths. Vector1.count = \(vector1.count), Vector2.count = \(vector2.count)")
    }
    var result = [Double](repeating: 0, count: vector1.count)
    for i in vector1.indices {
      result[i] = vector1[i] + vector2[i]
    }

    return result
  }

  static func vectorSubtraction(vector1: [Double], vector2: [Double]) -> [Double] {
    if vector1.count != vector2.count {
      fatalError("Trying to subtract vectors of different lengths. Vector1.count = \(vector1.count), Vector2.count = \(vector2.count)")
    }
    var result = [Double](repeating: 0, count: vector1.count)
    for i in vector1.indices {
      result[i] = vector1[i] - vector2[i]
    }

    return result
  }

  static func scalarMultiplication(vector: [Double], scalar: Double) -> [Double] {
    var result = [Double](repeating: 0, count: vector.count)
    for (i, _) in vector.enumerated() {
      result[i] = scalar * vector[i]
    }
    return result
  }

  static func normalize(vector: [Double]) -> [Double] {
    let m = vectorMagnitude(v: vector)
    if m == 0 {
      return vector
    }
    return scalarMultiplication(vector: vector, scalar: 1 / m)
  }

  static func vectorMagnitude(v: [Double]) -> Double {
    return sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2])
  }

  static func crossProduct(vector1: [Double], vector2: [Double], normed: Bool = false) -> [Double] {
    var vector = [Double](repeating: 0, count: 3)
    var result = [Double]()
    if normed {
      vector[0] = vector1[1] * vector2[2] - vector1[2] * vector2[1]
      vector[1] = vector1[2] * vector2[0] - vector1[0] * vector2[2]
      vector[2] = vector1[0] * vector2[1] - vector1[1] * vector2[0]

      result = normalize(vector: vector)
    } else {
      vector[0] = vector1[1] * vector2[2] - vector1[2] * vector2[1]
      vector[1] = vector1[2] * vector2[0] - vector1[0] * vector2[2]
      vector[2] = vector1[0] * vector2[1] - vector1[1] * vector2[0]

      result = vector
    }

    return result
  }

  static func multiplyMV2(matrix: [[Double]], vector: [Double]) -> [Double] {
    var result = [Double](repeating: 0, count: 3)

    for i in 0...2 {
      var value = 0.0
      for j in 0...2 {
        value += matrix[i][j] * vector[j]
      }
      result[i] = value
    }

    return result
  }

  static func getRotationMatrixFromVector(rotationVector: [Double], nDim: Int) -> [Double] {
    var result = [Double](repeating: 0, count: nDim)

    var q0: Double
    let q1 = rotationVector[0]
    let q2 = rotationVector[1]
    let q3 = rotationVector[2]

    if rotationVector.count >= 4 {
      q0 = rotationVector[3]
    } else {
      q0 = 1.0 - q1 * q1 - q2 * q2 - q3 * q3
      if q0 > 0 {
        q0 = sqrt(q0)
      } else {
        q0 = 0.0 // this should nerver happen
      }
    }

    let sq_q1 = 2.0 * q1 * q1
    let sq_q2 = 2.0 * q2 * q2
    let sq_q3 = 2.0 * q3 * q3
    let q1_q2 = 2.0 * q1 * q2
    let q3_q0 = 2.0 * q3 * q0
    let q1_q3 = 2.0 * q1 * q3
    let q2_q0 = 2.0 * q2 * q0
    let q2_q3 = 2.0 * q2 * q3
    let q1_q0 = 2.0 * q1 * q0

    if nDim == 9 {
      result[0] = 1.0 - sq_q2 - sq_q3
      result[1] = q1_q2 - q3_q0
      result[2] = q1_q3 + q2_q0

      result[3] = q1_q2 + q3_q0
      result[4] = 1.0 - sq_q1 - sq_q3
      result[5] = q2_q3 - q1_q0

      result[6] = q1_q3 - q2_q0
      result[7] = q2_q3 + q1_q0
      result[8] = 1.0 - sq_q1 - sq_q2

    } else if nDim == 16 {
      result[0] = 1.0 - sq_q2 - sq_q3
      result[1] = q1_q2 - q3_q0
      result[2] = q1_q3 + q2_q0
      result[3] = 0.0

      result[4] = q1_q2 + q3_q0
      result[5] = 1.0 - sq_q1 - sq_q3
      result[6] = q2_q3 - q1_q0
      result[7] = 0.0

      result[8] = q1_q3 - q2_q0
      result[9] = q2_q3 + q1_q0
      result[10] = 1.0 - sq_q1 - sq_q2
      result[11] = 0.0

      result[14] = 0.0
      result[13] = result[14]
      result[12] = result[13]
      result[15] = 1.0
    }

    return result
  }

  static func matrixMultiplication(matrix: [[Double]], vector: [Double]) -> [Double] {
    var newV = [Double]()
    for i in matrix[0].indices {
      var value = 0.0
      for j in matrix.indices {
        value += matrix[j][i] * vector[j]
      }
      newV.append(value)
    }
    return newV
  }

  static func getRotatedAxisAngleOnPlane(rotationVector: [Double], axis: [Double]) -> Double {
    let rotatedYAxis = VectorUtils.multiplyMV2(
      matrix: getRotationMatrixFromVector(rotationVector: rotationVector, nDim: 9).asMatrix,
      vector: axis
    )

    var resultingAngle = -atan2(rotatedYAxis[0], rotatedYAxis[1])

    if resultingAngle < 0.0 {
      resultingAngle += Double.TAU
    }

    return resultingAngle
  }

  static func vectorAbs(vector: [Double]) -> [Double] {
    var result = [Double](repeating: 0, count: vector.count)
    for i in vector.indices {
      result[i] = abs(vector[i])
    }
    return result
  }

  static func projectOn(matrix: [[Double]], direction: [Double]) -> [Double] {
    // This is matrix multiplication
    var ret = [Double]()
    matrix.forEach { ret.append($0.dot(vector: direction)) }
    return ret
  }
}

public extension Array {
  static func elementsEqualUpToTolerance(matrixA: [[Double]], matrixB: [[Double]], tolerance: Double) -> Bool {
    if (matrixA.count != matrixB.count) {
      return false
    }
    for i in matrixA.indices {
      if (!Array<Double>.elementsEqualUpToTolerance(vectorA: matrixA[i], vectorB: matrixB[i], tolerance: tolerance)) {
        return false
      }
    }
    return true

  }

  static func elementsEqualUpToTolerance(vectorA: [Double], vectorB: [Double], tolerance: Double) -> Bool {
    if (vectorA.count != vectorB.count) {
      return false
    }
    for i in vectorA.indices {
      if (abs(vectorA[i] - vectorB[i]) > tolerance) {
        return false
      }
    }
    return true
  }
}

public extension Array where Element == Double {

  func dot(vector: [Double]) -> Double {
    var ret = 0.0
    for i in 0..<count {
      ret += self[i] * vector[i]
    }
    return ret
  }
}
