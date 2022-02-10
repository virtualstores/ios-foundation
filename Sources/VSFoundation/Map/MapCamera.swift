//
// Camera.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics

public struct Camera {
    let allowsTilting: Bool
    let allowsScrolling: Bool
    let allowsZooming: Bool
    let allowsRotating: Bool
    
    var cameraLocked: Bool {
        allowsTilting && allowsScrolling && allowsZooming && allowsRotating
    }
    
    let minZoomLevel: Double?
    let maxZoomLevel: Double
    
    let cameraModePadding: Double
    
    public init(allowsTilting: Bool = true, allowsScrolling: Bool = true, allowsZooming: Bool = true,
                allowsRotating: Bool = true, minZoomLevel: Double? = nil, maxZoomLevel: Double = 9,
                cameraModePadding: Double = 16) {
        self.allowsTilting = allowsTilting
        self.allowsScrolling = allowsScrolling
        self.allowsZooming = allowsZooming
        self.allowsRotating = allowsRotating
        
        self.minZoomLevel = minZoomLevel
        self.maxZoomLevel = maxZoomLevel
        
        self.cameraModePadding = cameraModePadding
    }
}
