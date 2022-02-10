//
// PositionBundle
// VSEngineWrapper
//
// Created by Hripsime on 2021-12-30
// Copyright Virtual Stores - 2021
//

import Foundation
import CoreGraphics

public struct PositionBundle {
    public let position: CGPoint
    public let std: Float?
    
    public init(x: Float, y: Float, std: Float?) {
        self.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
        self.std = std
    }
}
