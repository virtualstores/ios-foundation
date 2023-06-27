//
// MapMark.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics
import UIKit

public protocol MapMark {
    var id: String { get }
    var position: CGPoint { get }
    var offset: CGVector { get }
    var floorLevelId: Int64? { get }
    var data: Any? { get }
    var triggerRadius: Double? { get }
    var clusterable: Bool { get }
    var defaultVisibility: Bool { get }
    var focused: Bool { get }
    
    func createViewHolder(completion: @escaping (MapMarkViewHolder) -> ())
    //onFinish: (viewHolder: MapMarkViewHolder) -> Unit)
}

public extension MapMark {
  var asGoal: PathfindingGoal { PathfindingGoal(id: id, position: position, data: data, type: .target, floorLevelId: floorLevelId) }
}
