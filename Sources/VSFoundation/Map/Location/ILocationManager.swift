//
// ILocationManager.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-09.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreLocation
import CoreGraphics

final public class ILocationManager: ILocation {
    public var userMarkVisibility: UserMarkVisibility
    public var position: CLLocation?
        
    init(with position: CLLocation?, userMarkVisibility: UserMarkVisibility) {
        self.position = position
        self.userMarkVisibility = userMarkVisibility
    }

    public func updateUserLocation(newLocation: CGPoint?, precision: Float) {
        
    }

    public func updateUserDirection(newDirection: Double) {
        
    }
    
    public func reset() {
        
    }
}
