//
// IMap.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit
import CoreLocation

public protocol IMap {
    /// location manager for handling location updates
    var location: ILocation { get }
    
    /// User location
    var position: CLLocation? { get }
    
    /// MapBox view
    var mapView: UIView? { get }

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
