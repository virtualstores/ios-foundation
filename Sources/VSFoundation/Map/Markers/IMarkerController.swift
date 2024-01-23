//
// IMarkerController.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics
import Combine

public protocol IMarkerController {
    /// Access to allMarks in the markerController
    var allMarkers: [MapMark] { get }

    var onMarkerClicked: CurrentValueSubject<MapMark?, Never> { get }
    
    /// Adds a mark and shows it on the map.
    /// It is useful for visualizing information related to a specific point on the map.
    /// If pathfinding to the mark is wanted, its recommended to use the same data and add a PathfindingGoal with [PathfindingController.addGoal].
    func add(marker: MapMark)
    
    /// Clears all current marks and replaces them with these
    func set(markers: [MapMark])
    
    /// Get a [MapMark] by using the id you assigned on creation
    func get(markerId id: String) -> MapMark
    
    /// Focus mark makes the mark with that id bigger is size.
    func focus(markerId id: String)
    
    /// Unfocus marks makes all focused marks go back to their original size.
    func unfocusMarkers()
    
    /// Remove mark, removes the input mark from the map.
    func remove(marker: MapMark)
    
    /// Remove mark, removes the input mark from the map.
    func remove(markerId id: String)
    
    /// Update location updates [MarkerController] with a new user position.
    /// The [MarkerController] need the latest user position for mark triggerlisteners to work correctly.
    func updateLocation(newLocation: CGPoint, precision: Double)
    
    func setStartLocationsVisibility(isVisible: Bool)
}
