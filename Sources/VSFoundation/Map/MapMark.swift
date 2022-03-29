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
    var floorLevelId: Int64? { get }
    var data: UIImage? { get }
    var triggerRadius: Double? { get }
    var clusterable: Bool { get }
    var deletable: Bool { get }
    var defaultVisibility: Bool { get }
    var offsetX: Double { get }
    var offsetY: Double { get }
    
    func createViewHolder(onFinish: @escaping (MapMarkViewHolder) -> ())
    //onFinish: (viewHolder: MapMarkViewHolder) -> Unit)
}
