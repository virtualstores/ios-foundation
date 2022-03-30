//
//  Goal.swift
//  VSFoundation
//
//  Created by Hripsime on 2022-01-31.
//

import Foundation
import CoreGraphics

//TODO: BaseMapGole
public struct Goal {
    public let id: String
    public let position: CGPoint
    public let data: Any?
    public let type: GoalType
    public let floorLevelId: Int64?

    public enum GoalType {
        case end, start, target
    }

    public init(id: String, position: CGPoint, data: Any?, type: GoalType, floorLevelId: Int64?) {
        self.id = id
        self.position = position
        self.data = data
        self.type = type
        self.floorLevelId = floorLevelId
    }
}
