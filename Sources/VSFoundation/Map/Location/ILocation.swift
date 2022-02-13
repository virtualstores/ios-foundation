//
// ILocation.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-09.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics
import CoreLocation

public enum UserMarkVisibility {
    case none
    case radius
    case visible
}

public protocol ILocation {
    /// User mark visibility type
    var userMarkVisibility: UserMarkVisibility { get }
    
    /// User location
    var position: CLLocation? { get }
        
    /// Updates the position of the userMark
    /// newLocation: The new position for the user
    /// precision:   The radius of the precisionCircle
    /// locaten as latitude and longitude
    func updateUserLocation(newLocation: CGPoint, std: Float?)
    
    /// Updates the users direction depending on which direction you last synced
    /// newDirection  The direction in radians
    func updateUserDirection(newDirection: Double)
    
    /// Reset user location
    func reset()
}
