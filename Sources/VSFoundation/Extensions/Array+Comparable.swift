//
// Array+Comparable.swift
// VSFoundation
//
// Created by Gabriel Sabadin on 2021-12-20.
// Copyright (c) 2021 Virtual Stores
//

import Foundation

public extension Array where Element: Hashable {
  @inlinable func difference(_ other: [Element]) -> [Element] {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.symmetricDifference(otherSet))
  }

  @inlinable func elementsEqual(_ other: [Element],
                                ignoreOrder: Bool) -> Bool {
    if ignoreOrder {
      return self.difference(other).isEmpty
    } else {
      return self.elementsEqual(other)
    }
  }
}

public extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
