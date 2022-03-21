//
// ICameraController.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics
import CoreLocation

public protocol ICameraController {    
    /// Method for updating camera mode  when location changed
    func updateLocation(with newLocation: CLLocationCoordinate2D, direction: Double)

    /// Method for updating camera mode  from camera controller
    func updateCameraMode(with mode: CameraModes)
    
    /// Update camera mode with some delay
    func setAutoCameraResetDelay(with milliseconds: Int64)
    
    /// Will reset camera mode
    func resetCameraMode()
}
