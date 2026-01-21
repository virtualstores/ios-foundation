//
//  FloorData.swift
//  
//
//  Created by Théodore Roos on 2023-05-22.
//

import Foundation
import CoreLocation

public struct FloorData {
  public let rtls: RtlsOptions
  public let mapFence: MapFence
  public let zones: [Zone]?
  public let metersToNextFloor: Double
  public let converter: ICoordinateConverter
  public let storeCoordinate: CLLocationCoordinate2D

  public init(rtls: RtlsOptions, mapFence: MapFence, zones: [Zone]? = nil, metersToNextFloor: Double = 3.6, converter: ICoordinateConverter, storeCoordinate: CLLocationCoordinate2D) {
    self.rtls = rtls
    self.mapFence = mapFence
    self.zones = zones
    self.metersToNextFloor = metersToNextFloor
    self.converter = converter
    self.storeCoordinate = storeCoordinate
  }
}
