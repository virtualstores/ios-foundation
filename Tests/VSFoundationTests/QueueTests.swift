// QueueTests.swift
// VSFoundationTests

// Created by: CJ on 2021-12-11
// Copyright (c) 2021 Virtual Stores

import XCTest
import Foundation
@testable import VSFoundationt

final class QueueTests: XCTestCase {

  let testStrings = ["foo1", "foo2", "foo3", "foo4", "foo5", "foo6", "foo7", "foo8", "foo9"]

  func test_queue_addition() throws {
    let queue = Queue<String>()

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])

    XCTAssertEqual(testStrings[0], queue.dequeue())
    XCTAssertEqual(testStrings[1], queue.dequeue())
    XCTAssertEqual(testStrings[2], queue.dequeue())

    XCTAssertEqual(queue.count, 0)

    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[0])

    XCTAssertEqual(testStrings[2], queue.dequeue())
    XCTAssertEqual(testStrings[1], queue.dequeue())
    XCTAssertEqual(testStrings[0], queue.dequeue())

    XCTAssertEqual(queue.count, 0)
  }

  func test_dequeue_last() throws {
    let queue = Queue<String>()

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[3])

    XCTAssertEqual(testStrings[3], queue.dequeueLast())
    XCTAssertEqual(testStrings[2], queue.dequeueLast())
    XCTAssertEqual(testStrings[1], queue.dequeueLast())
    XCTAssertEqual(testStrings[0], queue.dequeueLast())
    XCTAssertNil(queue.dequeueLast())
    XCTAssertNil(queue.dequeueLast())
    XCTAssertNil(queue.dequeueLast())

    XCTAssertEqual(queue.count, 0)

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])

    XCTAssertEqual(testStrings[0], queue.dequeue())
    XCTAssertEqual(testStrings[1], queue.dequeue())
    XCTAssertEqual(testStrings[2], queue.dequeue())

    XCTAssertEqual(queue.count, 0)
  }

  func test_peak_last() throws {
    let queue = Queue<String>()

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[3])

    XCTAssertEqual(testStrings[3], queue.peekLast)
    XCTAssertEqual(queue.count, 4)
    XCTAssertEqual(testStrings[3], queue.dequeueLast())

    XCTAssertEqual(testStrings[2], queue.peekLast)
    XCTAssertEqual(queue.count, 3)
    XCTAssertEqual(testStrings[2], queue.dequeueLast())

    XCTAssertEqual(testStrings[1], queue.peekLast)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(testStrings[1], queue.dequeueLast())

    XCTAssertEqual(testStrings[0], queue.peekLast)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(testStrings[0], queue.dequeueLast())

    XCTAssertEqual(queue.count, 0)
  }

  func test_peak() throws {
    let queue = Queue<String>()

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[3])

    XCTAssertEqual(testStrings[0], queue.peek)
    XCTAssertEqual(queue.count, 4)
    XCTAssertEqual(testStrings[0], queue.dequeue())

    XCTAssertEqual(testStrings[1], queue.peek)
    XCTAssertEqual(queue.count, 3)
    XCTAssertEqual(testStrings[1], queue.dequeue())

    XCTAssertEqual(testStrings[2], queue.peek)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(testStrings[2], queue.dequeue())

    XCTAssertEqual(testStrings[3], queue.peek)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(testStrings[3], queue.dequeue())

    XCTAssertEqual(queue.count, 0)
  }

  func test_size_constrained_queue() throws {
    let queue = Queue<String>(maxSize: 3)

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[3])

    XCTAssertEqual(testStrings[1], queue.peek)
    XCTAssertEqual(testStrings[3], queue.peekLast)

    XCTAssertEqual(queue.count, 3)

    queue.enqueue(testStrings[4])
    queue.enqueue(testStrings[5])
    queue.enqueue(testStrings[6])

    XCTAssertEqual(testStrings[4], queue.peek)
    XCTAssertEqual(testStrings[6], queue.peekLast)

    XCTAssertEqual(testStrings[4], queue.dequeue())
    XCTAssertEqual(testStrings[5], queue.dequeue())
    XCTAssertEqual(testStrings[6], queue.dequeue())

    XCTAssertEqual(queue.count, 0)

    queue.enqueue(testStrings[7])
    queue.enqueue(testStrings[8])

    XCTAssertEqual(testStrings[7], queue.peek)
    XCTAssertEqual(testStrings[8], queue.peekLast)

    XCTAssertEqual(queue.count, 2)
  }

  func test_loop_dequeue() throws {
    let queue = Queue<String>(maxSize: 4)

    queue.enqueue(testStrings[0])
    queue.enqueue(testStrings[1])
    queue.enqueue(testStrings[2])
    queue.enqueue(testStrings[3])

    var count = 0
    while queue.peek != nil {
      XCTAssertEqual(testStrings[count], queue.dequeue())
      count += 1
    }

    XCTAssertEqual(queue.count, 0)
    XCTAssertTrue(queue.isEmpty)
  }

  func test_get_delayed_value() {
    let queue = Queue<String>(maxSize: 5)

    queue.enqueue(testStrings[0], timestamp: 1235)
    queue.enqueue(testStrings[1], timestamp: 1245)
    queue.enqueue(testStrings[2], timestamp: 1255)
    queue.enqueue(testStrings[3], timestamp: 1265)
    queue.enqueue(testStrings[4], timestamp: 1275)

    XCTAssertEqual(queue.getDelayedValue(timestamp: 1254, reversed: true), testStrings[1])

    XCTAssertEqual(queue.getDelayedValue(timestamp: 1254), testStrings[2])

    print(queue.description)
  }

  func test_clear() {
    let queue = Queue<String>(maxSize: 5)

    queue.enqueue(testStrings[0], timestamp: 1235)
    queue.enqueue(testStrings[1], timestamp: 1245)
    queue.enqueue(testStrings[2], timestamp: 1255)
    queue.enqueue(testStrings[3], timestamp: 1265)
    queue.enqueue(testStrings[4], timestamp: 1275)

    queue.clear()
    XCTAssertEqual(queue.count, 0)
    XCTAssertTrue(queue.isEmpty)

    queue.enqueue(testStrings[0], timestamp: 1235)
    queue.enqueue(testStrings[1], timestamp: 1245)
    queue.enqueue(testStrings[2], timestamp: 1255)
    queue.enqueue(testStrings[3], timestamp: 1265)
    queue.enqueue(testStrings[4], timestamp: 1275)

    XCTAssertEqual(queue.count, 5)
    XCTAssertFalse(queue.isEmpty)
  }

  func test_queue_description() {
    let queue = Queue<String>(maxSize: 4)

    queue.enqueue(testStrings[0], timestamp: 1235)
    queue.enqueue(testStrings[1], timestamp: 1245)
    queue.enqueue(testStrings[2], timestamp: 1255)
    queue.enqueue(testStrings[3], timestamp: 1265)

    XCTAssertEqual(queue.description, "foo1 -> foo2 -> foo3 -> foo4")
    queue.clear()
    XCTAssertEqual(queue.description, "Empty Queue")
  }

  func test_queue_as_array() {
    let queue = Queue<String>(maxSize: 4)
    let expectedResult = [testStrings[0], testStrings[1], testStrings[2], testStrings[3]]

    queue.enqueue(testStrings[0], timestamp: 1235)
    queue.enqueue(testStrings[1], timestamp: 1245)
    queue.enqueue(testStrings[2], timestamp: 1255)
    queue.enqueue(testStrings[3], timestamp: 1265)

    XCTAssertEqual(queue.asArray(), expectedResult)

    XCTAssertEqual(testStrings[0], queue.peek)
    XCTAssertEqual(testStrings[3], queue.peekLast)

    queue.clear()
    XCTAssertTrue(queue.asArray().isEmpty)
  }
}
