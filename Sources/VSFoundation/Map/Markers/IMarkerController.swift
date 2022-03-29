//
// IMarkerController.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreGraphics

public protocol IMarkerController {
    /// Access to allMarks in the markerController
    var allMarkers: [MapMark] { get }
    
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
    func updateLocation(newLocation: CGPoint, precision: Float)
    
    /// Add trigger listener will give an event when the user is inside the set radius from given mark.

    // fun addTriggerListener(listener: (MapMark<out Any>) -> Unit)
    
    /// Remove trigger listener removes a listener from trigger event updates.
    // func removeTriggerListener(listener: (MapMark<out Any>) -> Unit)
    
    func setStartLocationsVisibility(isVisible: Bool)
    
    //    func addListener(listener: Listener)
    //    func removeListener(listener: Listener)
    //
    //    interface Listener {
    //        fun onMarkClicked(mark: MapMark<out Any>)
    //        fun onClusterClicked(marks: List<MapMark<out Any>>)
    //    }
}
