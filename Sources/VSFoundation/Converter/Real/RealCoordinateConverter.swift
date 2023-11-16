//
//  RealCoordinateConverter.swift
//
//
//  Created by Théodore Roos on 2023-11-09.
//

import Foundation
import CoreGraphics
import CoreLocation

class RealCoordinateConverter {
  private let lngLatOrigin: CLLocationCoordinate2D
  private let mapAngleInDegrees: Double
  private let earthRadiusInMeters: Double
  private let pixelsPerMeter: Double

  private let oneDegreeInRadians: Double = .pi / 180
  private let oneRadiansInDegree: Double = 180 / .pi
  private let meterOrigin = CGPoint()

  private lazy var lngLatToMetersConstants: LngLatToMetersConstants = {
    buildLngLatToMetersConstants(lngLatOrigin: lngLatOrigin, mapAngleInDegrees: mapAngleInDegrees)
  }()
  private lazy var metersToLngLatConstants: MetersToLngLatConstants = {
    buildMetersToLngLatConstants(lngLatOrigin: lngLatOrigin, mapAngleInDegrees: mapAngleInDegrees)
  }()

  init(lngLatOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double, earthRadiusInMeters: Double, pixelsPerMeter: Double) {
    self.lngLatOrigin = lngLatOrigin
    self.mapAngleInDegrees = mapAngleInDegrees
    self.earthRadiusInMeters = earthRadiusInMeters
    self.pixelsPerMeter = pixelsPerMeter
    self.lngLatToMetersConstants = lngLatToMetersConstants
    self.metersToLngLatConstants = metersToLngLatConstants
  }
}

private extension RealCoordinateConverter {
  /// Builds the LngLatToMetersConstants
  /// from the given parameters. These
  /// values are constant for all given
  /// conversions with the provided
  /// lngLatOrigin & angleInDegrees and
  /// are only calculated once instead of
  /// per conversion.
  /// - Parameters:
  ///   - lngLatOrigin: The lngLatOrigin to calculate the constants from.
  ///   - mapAngleInDegrees: The angleInDegrees to calculate the constants from.
  /// - Returns: The calculated LngLatToMetersConstants.
  func buildLngLatToMetersConstants(lngLatOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double) -> LngLatToMetersConstants {
    let mCos = cos(degreesToRadians(degrees: lngLatOrigin.latitude))
    let mSin = sin(degreesToRadians(degrees: lngLatOrigin.latitude))

    return LngLatToMetersConstants(
      origin: LngLatToMetersConstants.Origin(
        lambda: degreesToRadians(degrees: lngLatOrigin.longitude),
        theta: degreesToRadians(degrees: lngLatOrigin.latitude),
        cos: mCos,
        sin: mSin,
        cosSquare: pow(mCos, 2),
        sinSquare: pow(mSin, 2),
        cosSin: mCos * mSin
      ),
      y: LngLatToMetersConstants.Y(
        cosDlCos: cos(0.0) * mCos,
        cosDlSin: cos(0.0) * mSin,
        sinDl: sin(0.0)
      ),
      rotate: Rotate(
        cos: cos(degreesToRadians(degrees: -mapAngleInDegrees)),
        sin: sin(degreesToRadians(degrees: -mapAngleInDegrees))
      ))
  }

  /// Converts degrees to radians.
  /// - Parameter degrees: The degrees to convert.
  /// - Returns: The resulting radians value.
  func degreesToRadians(degrees: Double) -> Double {
    degrees * oneDegreeInRadians
  }

  /// Converts radians to degrees.
  /// - Parameter radians: The radians to convert.
  /// - Returns: The resulting degrees value.
  private func radiansToDegrees(radians: Double) -> Double {
    radians * oneRadiansInDegree
  }

  /// Builds the MetersToLngLatConstants
  /// from the given parameters. These
  /// values are constant for all given
  /// conversions with the provided
  /// lngLatOrigin & angleInDegrees and
  /// are only calculated once instead of
  /// per conversion.
  /// - Parameters:
  ///   - lngLatOrigin: The lngLatOrigin to calculate the constants from.
  ///   - mapAngleInDegrees: The angleInDegrees to calculate the constants from.
  /// - Returns: The calculated MetersToLngLatConstants.
  func buildMetersToLngLatConstants(lngLatOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double) -> MetersToLngLatConstants {
    MetersToLngLatConstants(
      longitude: degreesToRadians(degrees: lngLatOrigin.longitude),
      latitude: degreesToRadians(degrees: lngLatOrigin.latitude),
      rotate: Rotate(
        cos: cos(degreesToRadians(degrees: mapAngleInDegrees)),
        sin: sin(degreesToRadians(degrees: mapAngleInDegrees))
      ))
  }

  /// Rotates the given point around
  /// the specified center and rounds
  /// the result in order to give a
  /// more consistent conversion, that
  /// is, if a given point is converted
  /// between meters & lngLat multiple
  /// times then the original point is
  /// more likely to be closer to the
  /// final point.
  /// - Parameters:
  ///   - center: The anchor to rotate around.
  ///   - coordinate: The point to rotate.
  /// - Returns: The rotated point rounded with 2 decimal places.
  private func rotateLngLatToMeters(center: CGPoint, coordinate: CLLocationCoordinate2D) -> CGPoint {
    CGPoint(
      x: round(value: (lngLatToMetersConstants.rotate.cos * (coordinate.longitude - center.x)) +
               (lngLatToMetersConstants.rotate.sin * (coordinate.latitude - center.y)) +
               center.x),
      y: round(value: (lngLatToMetersConstants.rotate.cos * (coordinate.latitude - center.y)) -
               (lngLatToMetersConstants.rotate.sin * (coordinate.longitude - center.x)) +
               center.y)
    )
  }

  /// Rotates the given point around
  /// the specified center and rounds
  /// the result in order to give a
  /// more consistent conversion, that
  /// is, if a given point is converted
  /// between meters & lngLat multiple
  /// times then the original point is
  /// more likely to be closer to the
  /// final point.
  /// - Parameters:
  ///   - center: The anchor to rotate around.
  ///   - point: The point to rotate.
  /// - Returns: The rotated point rounded with 2 decimal places.
  func rotateMetersToLngLat(center: CGPoint, point: CGPoint) -> CGPoint {
    CGPoint(x: 
              round(value:
                      (metersToLngLatConstants.rotate.cos * (point.x - center.x)) +
                      (metersToLngLatConstants.rotate.sin * (point.y - center.y)) +
                      center.x), 
            y:
              round(value: 
                      (metersToLngLatConstants.rotate.cos * (point.y - center.y)) -
                      (metersToLngLatConstants.rotate.sin * (point.x - center.x)) +
                      center.y))
  }

  /// Rounds the given value to
  /// 2 decimal places. Math.round
  /// rounds 0.1 to 0, 0.5 to 1 and
  /// 0.9 to 1.
  /// - Parameter value: The value to round.
  /// - Returns: The rounded value to 2 decimal places, that is 0.125 will be rounded to 0.13.
  func round(value: Double) -> Double {
    (value * 100.0).rounded(.toNearestOrAwayFromZero) / 100.0
  }

  /// Calculates the hypotenuse distance
  /// using the pythagorean theorem.
  /// - Parameters:
  ///   - xDiff: The x diff.
  ///   - yDiff: The y diff.
  /// - Returns: The calculated distance.
  func pythagorean(xDiff: Double, yDiff: Double) -> Double {
    sqrt(pow(xDiff, 2) + pow(yDiff, 2))
  }

  /// Determines the meter x value
  /// for the given longitude.
  /// - Parameter longitude: The value to convert.
  /// - Returns: The meter x value.
  func determineLngLatToMetersX(longitude: Double) -> Double {
    let lambda = degreesToRadians(degrees: longitude)
    let dlambda = lambda - lngLatToMetersConstants.origin.lambda
    let cosDl = cos(dlambda)
    let sinDl = sin(dlambda)
    let numerator = sqrt(
      (lngLatToMetersConstants.origin.cosSquare * pow(sinDl, 2)) +
      pow((lngLatToMetersConstants.origin.cosSin -
           (lngLatToMetersConstants.origin.cosSin * cosDl)), 2)
    )

    let denominator = lngLatToMetersConstants.origin.sinSquare + (lngLatToMetersConstants.origin.cosSquare * cosDl)
    // Spherical special case of Vincenty's formulae
    let dsigma = atan2(numerator, denominator) * dlambda.sign()
    return earthRadiusInMeters * dsigma
  }

  /// Determines the meter y value
  /// for the given latitude.
  /// - Parameter latitude: The value to convert.
  /// - Returns: The meter y value.
  func determineLngLatToMetersY(latitude: Double) -> Double {
    let theta = degreesToRadians(degrees: latitude)
    let dtheta = theta - lngLatToMetersConstants.origin.theta
    let cos = cos(theta)
    let sin = sin(theta)
    let numerator = sqrt(
      pow(cos * lngLatToMetersConstants.y.sinDl, 2) +
      pow((lngLatToMetersConstants.origin.cos * sin) -
          (lngLatToMetersConstants.y.cosDlSin * cos), 2)
    )

    let denominator = (lngLatToMetersConstants.origin.sin * sin) + (lngLatToMetersConstants.y.cosDlCos * cos)
    // Spherical special case of Vincenty's formulae
    let dsigma = atan2(numerator, denominator) * dtheta.sign()
    return earthRadiusInMeters * dsigma
  }
}

extension RealCoordinateConverter: ICoordinateConverterReal {
  func lngLatToMeters(coordinate: CLLocationCoordinate2D) -> CGPoint {
    rotateLngLatToMeters(
      center: meterOrigin,
      coordinate: CLLocationCoordinate2D(
        latitude: determineLngLatToMetersY(latitude: coordinate.latitude),
        longitude: determineLngLatToMetersX(longitude: coordinate.longitude)
      ))
  }

  func metersToLngLat(point: CGPoint) -> CLLocationCoordinate2D {
    // rotate meterPoint using angle
    let mPoint = rotateMetersToLngLat(center: meterOrigin, point: point)
    let distanceInMeters = pythagorean(xDiff: mPoint.x, yDiff: mPoint.y)
    // bearing: vector angle
    let bearing = atan2(Double(mPoint.x), Double(mPoint.y))
    let newLatitude = asin(
      sin(metersToLngLatConstants.latitude) * cos(distanceInMeters / earthRadiusInMeters) +
      cos(metersToLngLatConstants.latitude) * sin(distanceInMeters / earthRadiusInMeters) *
      cos(bearing)
    )

    let newLongitude = metersToLngLatConstants.longitude + atan2(
      sin(bearing) * sin(distanceInMeters / earthRadiusInMeters) * cos(newLatitude),
      cos(distanceInMeters / earthRadiusInMeters) - pow(sin(newLatitude), 2)
    )
    return CLLocationCoordinate2D(
      latitude: radiansToDegrees(radians: newLatitude),
      longitude: radiansToDegrees(radians: newLongitude)
    )
  }

  func metersToPixel(point: CGPoint) -> CGPoint {
    point.multiply(value: pixelsPerMeter)
  }

  func pixelsToMeter(point: CGPoint) -> CGPoint {
    point.divide(value: pixelsPerMeter)
  }
}
