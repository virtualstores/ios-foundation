// VectorUtilsTest.swift
// VSFoundationTests

// Created by: CJ on 2021-12-16
// Copyright (c) 2021 Virtual Stores

import XCTest
import Foundation
@testable import VSFoundation

final class VectorUtilsTest: XCTestCase {

  func test_dot_product() throws {
    let vector1 = [-0.2927565, 0.16749744, 0.021124821]
    let vector2 = [-0.3999334, 1.7934148, 9.63638]
    let expectedResult = -0.6210423

    let result = -VectorUtils.dotProduct(vector1: vector1, vector2: vector2)
    XCTAssertTrue(abs(result - expectedResult) < Double.arbitraryTolerance)
  }

  func test_multiply_with_scalar() throws {
    let vector = [-0.39407927, 1.7675043, 9.641407]
    let scalar = 0.001916957
    let expectedResult = [-7.55433E-4, 0.0033882298, 0.018482162]

    let result = VectorUtils.scalarMultiplication(vector: vector, scalar: scalar)

    XCTAssertTrue(Array.compareArraysUpToTolerance(array1: result, array2: expectedResult, tolerance: .arbitraryTolerance))
  }

  func test_normalize_vector() throws {
    let vector = [0.0, 9.641407, -1.7675043]
    let expectedResult = [0.0, 0.9836082, -0.1803193]

    let result = VectorUtils.normalize(vector: vector)

    XCTAssertTrue(Array.compareArraysUpToTolerance(array1: result, array2: expectedResult, tolerance: 0.0000001))
  }

  func testVectorAddition() throws {
    XCTAssertEqual(VectorUtils.vectorAddition(vector1: Array.toyVector1, vector2: Array.toyVector2), Array.knownSum1plus2)
    XCTAssertEqual(VectorUtils.vectorAddition(vector1: Array.toyVector1, vector2: Array.toyVector3), Array.knownSum1plus3)
    XCTAssertEqual(VectorUtils.vectorSubtraction(vector1: Array.toyVector1, vector2: Array.toyVector2), Array.knownSum1minus2)
    XCTAssertEqual(VectorUtils.vectorSubtraction(vector1: Array.toyVector1, vector2: Array.toyVector3), Array.knownSum1minus3)
    XCTAssertEqual(VectorUtils.vectorSubtraction(vector1: Array.toyVector1, vector2: Array.toyVector1), Array.knownSum1minus1)
    XCTAssertEqual(VectorUtils.vectorSubtraction(vector1: Array.toyVector2, vector2: Array.toyVector1), Array.knownSum2minus1)

  }

  func testMatrixMultiplication() throws {
    XCTAssertEqual(VectorUtils.matrixMultiplication(matrix: Array.toyMatrix, vector: Array.toyVector1), Array.knownProduct1)
    XCTAssertEqual(VectorUtils.matrixMultiplication(matrix: Array.toyMatrix, vector: Array.toyVector2), Array.knownProduct2)
    XCTAssertEqual(VectorUtils.matrixMultiplication(matrix: Array.toyMatrix, vector: Array.toyVector3), Array.knownProduct3)
  }
}

extension Array where Element == Double {
  //Toy arrays
  static let toyMatrix = [[1.0, 0.0, 1.0], [1.0, 2.0, 0.0], [2.0, 0.0, 3.0]]
  static let toyVector1 = [1.0, 2.0, 3.0]
  static let toyVector2 = [1.0, 0.0, 0.0]
  static let toyVector3 = [1.0, 0.0, 1.0]
  static let knownProduct1 = [1.0 + 2.0 + 6.0, 0.0 + 4.0 + 0.0, 1.0 + 0.0 + 9.0]
  static let knownProduct2 = [1.0, 0.0, 1.0]
  static let knownProduct3 = [1.0 + 2.0, 0.0 + 0.0, 1.0 + 3.0]
  static let knownSum1plus2 = [2.0, 2.0, 3.0]
  static let knownSum1plus3 = [2.0, 2.0, 4.0]
  static let knownSum1minus2 = [0.0, 2.0, 3.0]
  static let knownSum1minus3 = [0.0, 2.0, 2.0]
  static let knownSum1minus1 = [0.0, 0.0, 0.0]
  static let knownSum2minus1 = [0.0, -2.0, -3.0] // Just to make sure that there is no whacky shit with negative numbers
}

extension Double {
  static let arbitraryTolerance = 0.000001
}
