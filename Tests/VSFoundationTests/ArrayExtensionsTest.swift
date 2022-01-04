// File.swift
// 

// Created by: CJ on 2022-01-04
// Copyright (c) 2022 ___ORGANIZATIONNAME___

import XCTest
@testable import VSFoundation

final class ArrayTrimTest: XCTestCase {

  func test_copy(){
    let doubleArray = [0.0, 1.1, 2.2, 3.3, 4.4]
    let intArray = [0, 1, 2, 3, 4]

    let doubleArray2 = [[0.0], [1.1], [2.2], [3.3], [4.4]]
    let intArray2 = [[0], [1], [2], [3], [4]]

    XCTAssertEqual(doubleArray.copy(), doubleArray)
    XCTAssertEqual(intArray.copy(), intArray)
    XCTAssertEqual(doubleArray2.copy(), doubleArray2)
    XCTAssertEqual(intArray2.copy(), intArray2)
  }

  func test_trim() {
    let array = [0.0, 1.1, 2.2, 3.3, 4.4]
    var expected = [0.0, 1.1, 2.2]
    XCTAssertEqual(array.trim(trimSize: 2, trimStrategy: .end), expected)

    expected = [2.2, 3.3, 4.4]
    XCTAssertEqual(array.trim(trimSize: 2, trimStrategy: .front), expected)
  }

  func test_sum(){
    let doubleArray = [0.0, 1.1, 2.2, 3.3]
    let expectedDouble = 6.6
    let intArray = [0, 1, 2, 3]
    let expectedInt = 6

    print(doubleArray.average())


    XCTAssertEqual(doubleArray.sum(), expectedDouble)
    XCTAssertEqual(intArray.sum(), expectedInt)

  }

  func test_average(){
    let doubleArray = [0.0, 1.1, 2.2, 3.3]
    let expectedAverageDouble = 1.65

    let intArray = [0, 1, 2, 3]
    let expectedAvarageInt = 1
    let expectedAvarageFloat:Float = 1.5

    XCTAssertEqual(doubleArray.average(), expectedAverageDouble)
    XCTAssertEqual(intArray.average(), expectedAvarageInt)
    let result: Float = intArray.average()
    XCTAssertEqual(result, expectedAvarageFloat)

  }
}
