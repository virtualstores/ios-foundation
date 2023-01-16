//
// PositionedCode
// VSFoundation
//
// Created by Hripsime on 2022-02-10
// Copyright Virtual Stores - 2022

import Foundation
import CoreGraphics

public struct TT2PointWithOffset {
    public var point: CGPoint
    public var offset: CGPoint
    
    public init(point: CGPoint, offset: CGPoint) {
        self.point = point
        self.offset = offset
    }
}
