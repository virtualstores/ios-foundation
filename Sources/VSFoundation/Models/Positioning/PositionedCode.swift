//
// PositionedCode
// VSFoundation
//
// Created by Hripsime on 2022-02-10
// Copyright Virtual Stores - 2022

import Foundation
import CoreGraphics

public struct PositionedCode: Codable, Equatable {
    public let code: String
    public let xPosition: CGFloat
    public let yPosition: CGFloat
    public let direction: Double
    public let isRouteLocation: Bool
    public let type: CodeType

    public var point: CGPoint { .init(x: xPosition, y: yPosition) }

    public enum CodeType: Int, Codable {
        case start = 0
        case stop = 1
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case xPosition = "x"
        case yPosition = "y"
        case direction
        case isRouteLocation
        case type
    }

    public init(code: String, xPosition: CGFloat, yPosition: CGFloat, direction: Double, isRouteLocation: Bool, type: CodeType) {
        self.code = code
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.direction = direction
        self.isRouteLocation = isRouteLocation
        self.type = type
    }
}
