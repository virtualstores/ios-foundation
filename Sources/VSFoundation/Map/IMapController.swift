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

    var path: IPathfinderController { get }

    var zone: IZoneController { get }

    var shelf: IShelfController { get }

    var mlPosition: IMLPositionLineController { get }

    var currentGPSCoordinate: CLLocationCoordinate2D? { get }

    var mapDataLoadedPublisher: CurrentValueSubject<Bool, MapControllerError> { get }

    func getCoordinate(point: CGPoint) -> CLLocationCoordinate2D
  
    /// Map loader which will receave all needed  setup information
    func loadMap(with mapData: MapData)

    /// Function called by TT2 Core SDK to pass information to Map SDK
    func setup(pathfinder: IPathfinder, zones: [Zone], sharedProperties: SharedZoneProperties?, shelves: [ShelfGroup], changedFloor: Bool)
    
    /// Updates the position of the userMark
    /// newLocation: The new position for the user
    /// precision:   The radius of the precisionCircle
    /// In meter scale
    func updateUserLocation(newLocation: CGPoint?, std: Double?)

    func updateMLPosition(point: CGPoint)

    func updateMLPosition(coordinate: CLLocationCoordinate2D)

    /// Updates the users direction depending on which direction you last synced
    /// newDirection  The direction in radians
    func updateUserDirection(newDirection: Double)

    func start()

    /// Stop  map
    func stop()

    func reset()
}

public enum MapControllerError: Error {
    case loadingFailed
}
