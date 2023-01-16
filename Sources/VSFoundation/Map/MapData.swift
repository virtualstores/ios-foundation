//
// MapData.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import CoreLocation

public class MapData {
    public var rtlsOptions: RtlsOptions
    public var pathFinder: IFoundationPathfinder?
    public var bounds: CLLocationCoordinate2D?
    public var zones: [Zone]
    public var shelves: [ShelfGroup]
    public var swapLocations: [SwapLocation]
    public var converter: ICoordinateConverter
    
    public init(rtlsOptions: RtlsOptions, pathFinder: IFoundationPathfinder? = nil, bounds: CLLocationCoordinate2D? = nil, zones: [Zone] = [], shelves: [ShelfGroup]  = [], swapLocations: [SwapLocation] = [], converter: ICoordinateConverter) {
        self.rtlsOptions = rtlsOptions
        self.pathFinder = pathFinder
        self.zones = zones
        self.shelves = shelves
        self.swapLocations = swapLocations
        self.converter = converter
    }
}
