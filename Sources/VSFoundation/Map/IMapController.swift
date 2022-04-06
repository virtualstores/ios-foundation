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

public protocol IMapControlerDelegate {
    func onMapLoaded()
}

public protocol IMapController {
    /// User location
    var camera: ICameraController { get }
    
    /// Map marker
    var marker: IMarkerController { get }

    var path: IPathfindingController { get }

    var zone: IZoneController { get }

    var mapDataLoadedPublisher: CurrentValueSubject<Bool?, MapControllerError> { get }

    /// Map loader which will receave all needed  setup information
    func loadMap(with mapData: MapData)

    func setup(pathfinder: IFoundationPathfinder, zones: [Zone], sharedProperties: SharedZoneProperties?, changedFloor: Bool)
    
    /// Updates the position of the userMark
    /// newLocation: The new position for the user
    /// precision:   The radius of the precisionCircle
    /// In meter scale
    func updateUserLocation(newLocation: CGPoint?, std: Float?)
    
    /// Updates the users direction depending on which direction you last synced
    /// newDirection  The direction in radians
    func updateUserDirection(newDirection: Double)

    func addGoal(id: String, itemPosition: ItemPosition)

    func start()

    /// Stop  map
    func stop()
}

public enum MapControllerError: Error {
    case loadingFailed
}
