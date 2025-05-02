//
//  IMapboxOfflineManager.swift
//  VSFoundation
//
//  Created by Théodore Roos on 2025-05-02.
//

import CoreLocation

public protocol IMapboxOfflineManager {
  func downloadTileRegion(
    region: MapboxDownloadRegion,
    zoomRange: ClosedRange<UInt8>,
    styleProgressHandler: @escaping(Float) -> (),
    tileProgressHandler: @escaping(Float) -> (),
    completionHandler: @escaping(Bool) -> (),
    debugMode: Bool
  )

  func show()
  func hide()
}

public extension IMapboxOfflineManager {
  func downloadTileRegion(
    region: MapboxDownloadRegion,
    zoomRange: ClosedRange<UInt8> = 1...23,
    styleProgressHandler: @escaping(Float) -> () = {_ in },
    tileProgressHandler: @escaping(Float) -> () = {_ in },
    completionHandler: @escaping(Bool) -> () = {_ in },
    debugMode: Bool = false
  ) {
    downloadTileRegion(
      region: region,
      zoomRange: zoomRange,
      styleProgressHandler: styleProgressHandler,
      tileProgressHandler: tileProgressHandler,
      completionHandler: completionHandler,
      debugMode: debugMode
    )
  }
}

public struct MapboxDownloadRegion {
  public var regionId: String
  public var tileRegionTag: String
  public var tileRegionValue: String
  public var stylePackTag: String
  public var stylePackValue: String
  public var coordinates: [[CLLocationCoordinate2D]]

  public init(regionId: String, tileRegionTag: String, tileRegionValue: String, stylePackTag: String, stylePackValue: String, coordinates: [[CLLocationCoordinate2D]]) {
    self.regionId = regionId
    self.tileRegionTag = tileRegionTag
    self.tileRegionValue = tileRegionValue
    self.stylePackTag = stylePackTag
    self.stylePackValue = stylePackValue
    self.coordinates = coordinates
  }

  public static let alvdalen = MapboxDownloadRegion(
    regionId: "Alvdalen-region",
    tileRegionTag: "tileRegionAlvdalen",
    tileRegionValue: "alvdalen-tile-region",
    stylePackTag: "stylePackAlvdalen",
    stylePackValue: "alvdalen-style-pack",
    coordinates: [
      [
        //  Bottom left
        CLLocationCoordinate2D(latitude: 61.154, longitude: 12.920),
        //  Top left
        CLLocationCoordinate2D(latitude: 62.021, longitude: 12.920),
        //  Top right
        CLLocationCoordinate2D(latitude: 62.021, longitude: 14.405),
        //  Bottom right
        CLLocationCoordinate2D(latitude: 61.154, longitude: 14.405),
        //  Bottom left
        CLLocationCoordinate2D(latitude: 61.154, longitude: 12.920),
      ]
    ]
  )

  public static let sthlm = MapboxDownloadRegion(
    regionId: "Sthlm-region",
    tileRegionTag: "tileRegionSthlm",
    tileRegionValue: "sthlm-tile-region",
    stylePackTag: "stylePackSthlm",
    stylePackValue: "sthlm-style-pack",
    coordinates: [
      [
        //  Bottom left
        CLLocationCoordinate2D(latitude: 59.272, longitude: 17.793),
        //  Top left
        CLLocationCoordinate2D(latitude: 59.471, longitude: 17.793),
        //  Top right
        CLLocationCoordinate2D(latitude: 59.471, longitude: 18.334),
        //  Bottom right
        CLLocationCoordinate2D(latitude: 59.272, longitude: 18.334),
        //  Bottom left
        CLLocationCoordinate2D(latitude: 59.272, longitude: 17.793),
      ]
    ]
  )
}
