//
// ItemPosition
// VSTT2
//
// Created by Hripsime on 2022-01-12
// Copyright Virtual Stores - 2021

import Foundation
import CoreGraphics

public struct ItemPosition: Codable {
    public let xPosition: Double
    public let yPosition: Double
    public let offsetX: Double
    public let offsetY: Double
    public let floorLevelId: Int64?
    public let shelfId: Int64?
    public let identifier: String

    public init(xPosition: Double, yPosition: Double, offsetX: Double, offsetY: Double, floorLevelId: Int64?, shelfId: Int64? = nil, identifier: String? = nil) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.floorLevelId = floorLevelId
        self.shelfId = shelfId
        self.identifier = identifier ?? "undefined"
    }

    public init(point: CGPoint, offset: CGVector, floorLevelId: Int64?, shelfId: Int64? = nil, identifier: String? = nil) {
        self.xPosition = Double(point.x)
        self.yPosition = Double(point.y)
        self.offsetX = Double(offset.dx)
        self.offsetY = Double(offset.dy)
        self.floorLevelId = floorLevelId
        self.shelfId = shelfId
        self.identifier = identifier ?? "undefined"
    }

    public var point: CGPoint {
        CGPoint(x: xPosition, y: yPosition)
    }

    public var offset: CGVector {
        CGVector(dx: offsetX, dy: offsetY)
    }
    
    public var offsetPoint: CGPoint {
        CGPoint(x: offsetX, y: offsetY)
    }

    public var pointWithOffset: CGPoint {
        CGPoint(x: point.x + offset.dx, y: point.y + offset.dy)
    }
}

