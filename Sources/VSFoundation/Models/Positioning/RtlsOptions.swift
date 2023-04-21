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
    public let width: Double
    public let height: Double
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

    public var rtlsOptionsWidth: Double { widthInMeters > 0.0 ? widthInMeters : width }
    public var rtlsOptionsHeight: Double { heightInMeters > 0.0 ? heightInMeters : height }
    public var rtlsOptionsSize: CGSize { CGSize(width: rtlsOptionsWidth, height: rtlsOptionsHeight) }

    public init(id: Int64, width: Int64, height: Int64, widthInMeters: Double, heightInMeters: Double, floorLevel: Int?,
                north: Double?, name: String?, startOffsetX: Int64, startOffsetY: Int64, mapBoxUrl: String,
                mapBoxToken: String, mapFenceUrl: String, mapZonesUrl: String, navGraphUrl: String, mapOffsetsUrl: String,
                mapDataVersionUrl: String, mapBoxImageUrl: String, pixelsPerMeter: Double, boundingBoxInMeters: BoundingBox?, scanLocations: [PositionedCode], isDefault: Bool) {
        self.id = id
        self.width = Double(width)
        self.height = Double(height)
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
        public var topLeftPoint: CGPoint { CGPoint(x: topLeft[0], y: topLeft[1]) }
        public var topRightPoint: CGPoint { CGPoint(x: topRight[0], y: topRight[1]) }
        public var bottomRightPoint: CGPoint { CGPoint(x: bottomRight[0], y: bottomRight[1]) }
        public var padding: UIEdgeInsets { UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding) }

        public var asCGRect: CGRect {
          CGRect(
            origin: bottomLeftPoint,
            size: CGSize(width: topRightPoint.x - bottomLeftPoint.x, height: topRightPoint.y - bottomLeftPoint.y)
          )
        }

        public var asCGRectWithPadding: CGRect {
          CGRect(
            x: asCGRect.minX - padding.left,
            y: asCGRect.minY - padding.bottom,
            width: asCGRect.width + padding.right,
            height: asCGRect.height + padding.top
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
