//
//  Path.swift
//  PositionKit
//
//  Created by Hripsime on 2022-01-31.
//

import Foundation
import CoreGraphics

public struct Path {
    public let head: [CGPoint]
    public let body: [CGPoint]
    public let tail: [CGPoint]
    
    public init(head: [CGPoint], body: [CGPoint], tail: [CGPoint]) {
        self.head = head
        self.body = body
        self.tail = tail
    }
}
