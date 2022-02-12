//
// IMap.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit

public protocol IMap {
    /// MapBox view
    var mapView: UIView? { get }

    /// Map loader which will receave all needed  setup information
    func loadMap(with mapData: MapData)
}
