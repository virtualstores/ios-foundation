//
// ItemPosition
// VSTT2
//
// Created by Hripsime on 2022-01-12
// Copyright Virtual Stores - 2021

import Foundation
import CoreGraphics

public struct ItemPosition: Codable {
    private let xPosition: Double
    private let yPosition: Double
    private let offsetX: Double
    private let offsetY: Double
    public let floorLevelId: Int64? // For old version of scan event
    public let shelfId: Int64? // For old version of scan event
    public let shelfTierId: Int64? // For old version of scan event
    public let shelfTierPosition: Int64? // For old version of scan event
    public let shelfSectionId: String? // For new version of scan event
    public let sectionPosition: Int? // For new version of scan event
    public let shelfPositionFromLeftToRight: Int? // For new version of scan event
    public let identifier: String
    public let isDisabled: Bool

    public var point: CGPoint { CGPoint(x: xPosition, y: yPosition) }
    public var offset: CGVector { CGVector(dx: offsetX, dy: offsetY) }
    public var pointWithOffset: CGPoint { CGPoint(x: point.x + offset.dx, y: point.y + offset.dy) }

    public init(xPosition: Double, yPosition: Double, offsetX: Double, offsetY: Double, floorLevelId: Int64?, shelfId: Int64? = nil, shelfTierId: Int64? = nil, shelfTierPosition: Int64? = nil, identifier: String? = nil, isDisabled: Bool? = nil) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.floorLevelId = floorLevelId
        self.shelfId = shelfId
        self.shelfTierId = shelfTierId
        self.shelfTierPosition = shelfTierPosition
        self.shelfSectionId = nil
        self.sectionPosition = nil
        self.shelfPositionFromLeftToRight = nil
        self.identifier = identifier ?? "undefined"
        self.isDisabled = isDisabled ?? false
    }

    public init(point: CGPoint, offset: CGVector, floorLevelId: Int64?, shelfId: Int64? = nil, shelfTierId: Int64? = nil, shelfTierPosition: Int64? = nil, identifier: String? = nil, isDisabled: Bool? = nil) {
        self.xPosition = Double(point.x)
        self.yPosition = Double(point.y)
        self.offsetX = Double(offset.dx)
        self.offsetY = Double(offset.dy)
        self.floorLevelId = floorLevelId
        self.shelfId = shelfId
        self.shelfTierId = shelfTierId
        self.shelfTierPosition = shelfTierPosition
        self.shelfSectionId = nil
        self.sectionPosition = nil
        self.shelfPositionFromLeftToRight = nil
        self.identifier = identifier ?? "undefined"
        self.isDisabled = isDisabled ?? false
    }
}
