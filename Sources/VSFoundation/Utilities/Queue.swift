// Queue.swift
// VSFoundation

// Created by: CJ on 2021-12-11
// Copyright (c) 2021 Virtual Stores

import Foundation

open class Queue<T>: CustomStringConvertible {

  public class Node<T>: CustomStringConvertible {
    public var value: T
    public var timestamp: Int
    public var next: Node?
    public var previous: Node?

    public var description: String {
      guard let next = next else { return "\(value)" }
      return "\(value) -> " + String(describing: next)
    }

    public init(value: T, timestamp: Int? = nil, next: Node? = nil, previous: Node? = nil) {
      self.value = value
      self.next = next
      self.previous = previous
      self.timestamp = timestamp ?? Int(Date().timeIntervalSince1970 * 1000)
    }
  }

  var front: Node<T>? = nil
  var rear: Node<T>? = nil
  public var count: Int = 0
  var maxSize: Int? = nil

  public init() {}

  public init(maxSize: Int) {
    if maxSize < 2 {
      fatalError("Tried to init queue with maxSize=\(maxSize). A queue of size less than 2 is pointless and is not supported.")
    }
    self.maxSize = maxSize
  }

  public var isEmpty: Bool {
    front == nil
  }

  open var description: String {
    guard let front = self.front else { return "Empty Queue" }
    return String(describing: front)
  }

  open var peek: T? {
    front?.value
  }

  open var peekLast: T? {
    rear?.value
  }

  private func push(_ value: T, timestamp: Int? = nil) {
    front = Node(value: value, timestamp: timestamp, next: front)
    if rear == nil {
      rear = front
    }
  }

  open func clear() {
    front = nil
    rear = nil
    count = 0
  }

  open func enqueue(_ value: T, timestamp: Int? = nil) {
    if isEmpty {
      push(value, timestamp: timestamp)
      count += 1
      return
    }

    // If queue max size is reached, remove first item before enqueuing new node
    if let max = maxSize, count >= max {
      let newFront = front?.next
      newFront?.previous = nil
      front = newFront
      count -= 1
    }

    let newNode = Node(value: value, timestamp: timestamp)

    rear?.next = newNode
    newNode.previous = rear

    rear = rear?.next
    count += 1

  }

  open func dequeue() -> T? {
    defer {
      front = front?.next
      front?.previous = nil
      if isEmpty {
        rear = nil
      }
    }
    count -= 1
    return front?.value
  }

  open func dequeueLast() -> T? {
    if count == 1 {
      return dequeue()
    } else if !isEmpty {
      defer {
        rear = rear?.previous
        rear?.next = nil
      }

      count -= 1
      return rear?.value
    } else {
      return nil
    }
  }

  open func getDelayedValue(timestamp: Int, reversed: Bool = false) -> T? {
    if isEmpty {
      return nil
    }

    if reversed {
      var currentNode = rear
      while currentNode != nil {
        if let node = currentNode {
          if node.timestamp <= timestamp {
            return node.value
          }
          currentNode = node.previous
        }
      }
    } else {
      var currentNode = front
      while currentNode != nil {
        if let node = currentNode {
          if node.timestamp >= timestamp {
            return node.value
          }
          currentNode = node.next
        }
      }
    }
    return nil
  }

  open func asArray() -> [T] {
    if isEmpty {
      return []
    }

    if count == 1, let firstNode = front {
      return [firstNode.value]
    } else {
      var result: [T] = []
      var node: Node? = front
      while let n = node {
        result.append(n.value)
        node = n.next
      }
      return result.map { $0 }
    }
  }
}
