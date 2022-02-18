//
// IMapController.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit
import CoreLocation
import Combine

public protocol IMapController {
    /// User location
    var camera: ICameraController? { get }
    
    /// Publisher for receaving drag start on MapView
    var dragDidBeginPublisher: CurrentValueSubject<Bool, Never> { get }
    
    /// Publisher for receaving drag end on MapView
    var dragDidEndPublisher: CurrentValueSubject<Bool, Never> { get }

    /// Map loader which will receave all needed  setup information
    func loadMap(with mapData: MapData)
    
    /// Updates the position of the userMark
    /// newLocation: The new position for the user
    /// precision:   The radius of the precisionCircle
    /// In meter scale
    func updateUserLocation(newLocation: CGPoint?, std: Float?)
    
    /// Updates the users direction depending on which direction you last synced
    /// newDirection  The direction in radians
    func updateUserDirection(newDirection: Double)
}
