//
// RtlsOptions
// VSFoundation
//
// Created by Hripsime on 2022-02-10
// Copyright Virtual Stores - 2022

import Foundation
import CoreGraphics
import UIKit

public struct RtlsOptions: Codable {
    public let id: Int64
    public let widthInMeters: Double
    public let heightInMeters: Double
    public let floorLevel: Int
    public let north: Double?
    public let name: String?
    public let startOffsetX: Double
    public let startOffsetY: Double
    public let mapBoxUrl: String?
    public let mapBoxToken: String?
    public let mapFenceUrl: String?
    public let mapZonesUrl: String?
    public let navGraphUrl: String?
    public let mapOffsetsUrl: String?
    public let mapDataVersionUrl: String?
    public let mapBoxImageUrl: String?
    public let pixelsPerMeter: Double
    public let boundingBoxInMeters: BoundingBox?
    public let scanLocations: [PositionedCode]?
    public let isDefault: Bool

    public var size: CGSize { CGSize(width: widthInMeters, height: widthInMeters) }

    public init(id: Int64, widthInMeters: Double, heightInMeters: Double, floorLevel: Int?,
                north: Double?, name: String?, startOffsetX: Int64, startOffsetY: Int64, mapBoxUrl: String,
                mapBoxToken: String, mapFenceUrl: String, mapZonesUrl: String, navGraphUrl: String, mapOffsetsUrl: String,
                mapDataVersionUrl: String, mapBoxImageUrl: String, pixelsPerMeter: Double, boundingBoxInMeters: BoundingBox?, scanLocations: [PositionedCode], isDefault: Bool) {
        self.id = id
        self.widthInMeters = widthInMeters
        self.heightInMeters = heightInMeters
        self.floorLevel = floorLevel ?? 0
        self.north = north
        self.name = name
        self.startOffsetX = Double(startOffsetX)
        self.startOffsetY = Double(startOffsetY)
        self.mapBoxUrl = mapBoxUrl
        self.mapBoxToken = mapBoxToken
        self.mapFenceUrl = mapFenceUrl
        self.mapZonesUrl = mapZonesUrl
        self.navGraphUrl = navGraphUrl
        self.mapOffsetsUrl = mapOffsetsUrl
        self.mapDataVersionUrl = mapDataVersionUrl
        self.mapBoxImageUrl = mapBoxImageUrl
        self.pixelsPerMeter = pixelsPerMeter
        self.boundingBoxInMeters = boundingBoxInMeters
        self.scanLocations = scanLocations
        self.isDefault = isDefault
    }

    public struct BoundingBox: Codable {
        let bottomLeft: [Double]
        let topLeft: [Double]
        let topRight: [Double]
        let bottomRight: [Double]
        let leftPadding: Double
        let topPadding: Double
        let rightPadding: Double
        let bottomPadding: Double

        public var bottomLeftPoint: CGPoint { CGPoint(x: bottomLeft[0], y: bottomLeft[1]) }
        public var bottomLeftPointWithPadding: CGPoint { bottomLeftPoint.add(x: -leftPadding, y: -bottomPadding) }
        public var topLeftPoint: CGPoint { CGPoint(x: topLeft[0], y: topLeft[1]) }
        public var topLeftPointWithPadding: CGPoint { topLeftPoint.add(x: -leftPadding, y: topPadding) }
        public var topRightPoint: CGPoint { CGPoint(x: topRight[0], y: topRight[1]) }
        public var topRightPointWithPadding: CGPoint { topRightPoint.add(x: rightPadding, y: topPadding) }
        public var bottomRightPoint: CGPoint { CGPoint(x: bottomRight[0], y: bottomRight[1]) }
        public var bottomRightPointWithPadding: CGPoint { bottomRightPoint.add(x: rightPadding, y: -bottomPadding) }
        public var padding: UIEdgeInsets { UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding) }

        public var asRect: CGRect {
          CGRect(
            origin: bottomLeftPoint,
            size: CGSize(width: topRightPoint.x - bottomLeftPoint.x, height: topRightPoint.y - bottomLeftPoint.y)
          )
        }

        public var asRectWithPadding: CGRect {
          CGRect(
            x: asRect.minX - padding.left,
            y: asRect.minY - padding.bottom,
            width: asRect.width + padding.left + padding.right,
            height: asRect.height + padding.bottom + padding.top
          )
        }

        public init(bottomLeft: [Double], topLeft: [Double], topRight: [Double], bottomRight: [Double], leftPadding: Double, topPadding: Double, rightPadding: Double, bottomPadding: Double) {
            self.bottomLeft = bottomLeft
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomRight = bottomRight
            self.leftPadding = leftPadding
            self.topPadding = topPadding
            self.rightPadding = rightPadding
            self.bottomPadding = bottomPadding
        }
    }
}

public extension UIEdgeInsets {
  func multiply(with value: Double) -> UIEdgeInsets {
    UIEdgeInsets(top: top * value, left: left * value, bottom: bottom * value, right: right * value)
  }

  func multiply(width: Double, height: Double) -> UIEdgeInsets {
    UIEdgeInsets(top: top * height, left: left * width, bottom: bottom * height, right: right * width)
  }
}
