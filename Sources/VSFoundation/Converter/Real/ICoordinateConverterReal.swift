//
//  ICoordinateConverterReal.swift
//
//
//  Created by Théodore Roos on 2023-11-09.
//

import Foundation
import CoreGraphics
import CoreLocation

/// The ICoordinateConverter, contains logic
/// needed to swap between the pixel, meter &
/// lngLat coordinate systems.
protocol ICoordinateConverterReal {
  /// Converts a point from the lngLat
  /// coordinate system to the meter
  /// coordinate system.
  ///
  /// The resulting meter coordinate
  /// will be rotated so that the
  /// following points can be specified:
  ///
  /// (0, storeHeight) ____ (storeWidth, storeHeight)
  /// | x x x x x x x x x x x x x x x x x x x x x x x x x x |
  /// | x x x x x x x x x x x x x x x x x x x x x x x x x x |
  /// | x x x x x x x x x x x x x x x x x x x x x x x x x x |
  /// | x x x x x x x x x x x x x x x x x x x x x x x x x x |
  /// (0, 0) ___________________________ (storeWidth, 0)
  ///
  /// That is the meter origin will be
  /// located in the bottom left corner
  /// of the map and positive y with a
  /// x value of 0  will result in a
  /// coordinate that is straight up
  /// on the map. In the same way, a
  /// positive x value with a y value
  /// of 0 will result in a point going
  /// straight to the right.
  /// - Parameter point: The lngLat point to convert, index 0 is longitude & index 1 is latitude.
  /// - Returns: The converted point in meters, index 0 is x & index 1 is y.
  func lngLatToMeters(coordinate: CLLocationCoordinate2D) -> CGPoint

  /// Converts a point from the meter
  /// coordinate system to the lngLat
  /// coordinate system.
  ///
  /// This method will rotate the
  /// provided point with the inverted
  /// angle used when executing the
  /// lngLatToMeters method.
  /// - Parameter point: The meter point to convert, index 0 is x & index 1 is y.
  /// - Returns: The converted point in lngLat, index 0 is longitude & index 1 is latitude.
  func metersToLngLat(point: CGPoint) -> CLLocationCoordinate2D

  /// Converts a point from the meter
  /// coordinate system to the pixel
  /// coordinate system.
  /// - Parameter point: The meter point to convert, index 0 is x & index 1 is y.
  /// - Returns: The converted point in pixels, index 0 is x & index 1 y.
  func metersToPixel(point: CGPoint) -> CGPoint

  /// Converts a point from the pixel
  /// coordinate system to the meter
  /// coordinate system.
  /// - Parameter point: The pixel point to convert, index 0 is x & index 1 is y.
  /// - Returns: The converted point in meters, index 0 is x & index 1 y.
  func pixelsToMeter(point: CGPoint) -> CGPoint
}
