//
//  IZoneController.swift
//  
//
//  Created by Théodore Roos on 2022-03-31.
//

import Foundation
import CoreGraphics
import Combine

/**
 * Zone controller. Methods for handling zones on the map.
 *
 * @constructor Create empty constructor for zone controller
 */
public protocol IZoneController {
    var onEnterPublisher: CurrentValueSubject<Zone?, Never> { get }
    var onExitPublisher: CurrentValueSubject<Zone?, Never> { get }

    var zones: [Zone] { get }

    /**
     * Show text layer. Show the names of all zones that contain a name.
     */
    func showTextLayer()

    /**
     * Hide text layer. Hide the names of all zones that contain a name.
     */
    func hideTextLayer()

    /**
     * Show fill layer. Show the filled area of every zone on the map.
     */
    func showFillLayer()

    /**
     * Hide fill layer. Hide the filled area of every zone on the map.
     */
    func hideFillLayer()

    /**
     * Show line layer. Show outline of every zone on the map.
     */
    func showLineLayer()

    /**
     * Hide line layer. Hide outline of every zone on the map.
     */
    func hideLineLayer()

    /**
     * Show all layers. Show all zone layers. These are fill, line and text layers.
     */
    func showAllLayers()

    /**
     * Hide all layers. Hide all zone layers. These are fill, line and text layers.
     */
    func hideAllLayers()

    func showAll()
    func hideAll()

    func show(zone: Zone)
    func hide(zone: Zone)
    func select(zone: Zone)
    func select(zones: [Zone])
    func deselect(zone: Zone)
    func deselect(zones: [Zone])
    func deselectAll()

    func updateLocation(newLocation: CGPoint)
    func setInAndOutDataListener(completion: @escaping ([String]) -> Void)
}
