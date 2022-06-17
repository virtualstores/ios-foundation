//
// Shelf
// VSTT2
//
// Created by Hripsime on 2022-01-12
// Copyright Virtual Stores - 2021

import Foundation
import CoreGraphics

public class Shelf: Codable {
    public let id: Int64
    public let name: String
    public let itemPosition: ItemPosition
    public let shelfGroupPosition: Int
    public let shelfTiers: [ShelfTier]
    public let shape: [CGPoint]
    public var isVisible: Bool = false
    public var isSelected: Bool = false
    public var isMarked: Bool = false

    public init(id: Int64, name: String, itemPosition: ItemPosition, shelfGroupPosition: Int, shelfTiers: [ShelfTier], shape: [CGPoint]) {
        self.id = id
        self.name = name
        self.itemPosition = itemPosition
        self.shelfGroupPosition = shelfGroupPosition
        self.shelfTiers = shelfTiers
        self.shape = shape
    }
}
