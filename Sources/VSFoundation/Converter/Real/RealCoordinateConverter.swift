//
//  RealCoordinateConverter.swift
//
//
//  Created by Théodore Roos on 2023-11-09.
//

import CoreLocation

/// The RealCoordinateConverter, contains logic
/// needed to swap between the pixel, meter &
/// latLng coordinate systems. Each instance
/// of the RealCoordinateConverter is only
/// intended to be used with one map, that is
/// if you swap from one floor to another or
/// one store to another you should create a
/// new instace of this converter with the
/// new latLngOrigin, mapAngleInDegrees,
/// earthRadiusInMeters & pixelsPerMeter
/// values.
public class RealCoordinateConverter {
  private let latLngOrigin: CLLocationCoordinate2D
  private let mapAngleInDegrees: Double
  private let earthRadiusInMeters: Double
  private let pixelsPerMeter: Double

  private let oneDegreeInRadians: Double = .pi / 180
  private let oneRadiansInDegree: Double = 180 / .pi
  private let meterOrigin = CGPoint()

  private lazy var latLngToMetersConstants: LatLngToMetersConstants = {
    buildLatLngToMetersConstants(latLngOrigin: latLngOrigin, mapAngleInDegrees: mapAngleInDegrees)
  }()
  private lazy var metersToLatLngConstants: MetersToLatLngConstants = {
    buildMetersToLatLngConstants(latLngOrigin: latLngOrigin, mapAngleInDegrees: mapAngleInDegrees)
  }()

  /// Initiates the RealCoordinateConverter.
  /// - Parameters:
  ///   - latLngOrigin: Specifies the bottom left corner of the map as a latLng coordinate,
  ///                  this point will be used when converting between meters & latLng but
  ///                  also as a anchor when rotating points.
  ///   - mapAngleInDegrees: Specifies the map angle and thus the angle that each coordinate
  ///                       should be rotated with when converting between meters & latLng.
  ///                       Positive values results in the latLng map rotating counterclockwise
  ///                       (as the unit circle and not as the clock).
  ///   - earthRadiusInMeters: The earth radius in meters to use when converting between
  ///                         meters & latLng.
  ///   - pixelsPerMeter: Specifies how many pixels to use per meter when converting between
  ///                    meters & pixels.
  public init(latLngOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double, earthRadiusInMeters: Double, pixelsPerMeter: Double) {
    self.latLngOrigin = latLngOrigin
    self.mapAngleInDegrees = mapAngleInDegrees
    self.earthRadiusInMeters = earthRadiusInMeters
    self.pixelsPerMeter = pixelsPerMeter
    self.latLngToMetersConstants = latLngToMetersConstants
    self.metersToLatLngConstants = metersToLatLngConstants
  }
}

/// Extends the private functionality
/// of the RealCoordinateConverter.
private extension RealCoordinateConverter {
  /// Builds the LatLngToMetersConstants
  /// from the given parameters. These
  /// values are constant for all given
  /// conversions with the provided
  /// latLngOrigin & mapAngleInDegrees and
  /// are only calculated once instead of
  /// per conversion.
  /// - Parameters:
  ///   - latLngOrigin: The latLngOrigin to calculate the constants from.
  ///   - mapAngleInDegrees: The mapAngleInDegrees to calculate the constants from.
  /// - Returns: The calculated LatLngToMetersConstants.
  func buildLatLngToMetersConstants(latLngOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double) -> LatLngToMetersConstants {
    let mCos = cos(degreesToRadians(degrees: latLngOrigin.latitude))
    let mSin = sin(degreesToRadians(degrees: latLngOrigin.latitude))

    return LatLngToMetersConstants(
      origin: LatLngToMetersConstants.Origin(
        lambda: degreesToRadians(degrees: latLngOrigin.longitude),
        theta: degreesToRadians(degrees: latLngOrigin.latitude),
        cos: mCos,
        sin: mSin,
        cosSquare: pow(mCos, 2),
        sinSquare: pow(mSin, 2),
        cosSin: mCos * mSin
      ),
      y: LatLngToMetersConstants.Y(
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

  /// Builds the MetersToLatLngConstants
  /// from the given parameters. These
  /// values are constant for all given
  /// conversions with the provided
  /// latLngOrigin & mapAngleInDegrees and
  /// are only calculated once instead of
  /// per conversion.
  /// - Parameters:
  ///   - latLngOrigin: The latLngOrigin to calculate the constants from.
  ///   - mapAngleInDegrees: The mapAngleInDegrees to calculate the constants from.
  /// - Returns: The calculated MetersToLatLngConstants.
  func buildMetersToLatLngConstants(latLngOrigin: CLLocationCoordinate2D, mapAngleInDegrees: Double) -> MetersToLatLngConstants {
    MetersToLatLngConstants(
      longitude: degreesToRadians(degrees: latLngOrigin.longitude),
      latitude: degreesToRadians(degrees: latLngOrigin.latitude),
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
  /// between meters & latLng multiple
  /// times then the original point is
  /// more likely to be closer to the
  /// final point.
  /// - Parameters:
  ///   - center: The anchor to rotate around.
  ///   - coordinate: The point to rotate.
  /// - Returns: The rotated point rounded with 2 decimal places.
  private func rotateLatLngToMeters(center: CGPoint, point: CGPoint) -> CGPoint {
    CGPoint(x:
              round(value:
                      (latLngToMetersConstants.rotate.cos * (point.x - center.x)) -
                      (latLngToMetersConstants.rotate.sin * (point.y - center.y)) +
                      center.x),
            y:
              round(value:
                      (latLngToMetersConstants.rotate.cos * (point.y - center.y)) +
                      (latLngToMetersConstants.rotate.sin * (point.x - center.x)) +
                      center.y)
    )
  }

  /// Rotates the given point around
  /// the specified center and rounds
  /// the result in order to give a
  /// more consistent conversion, that
  /// is, if a given point is converted
  /// between meters & latLng multiple
  /// times then the original point is
  /// more likely to be closer to the
  /// final point.
  /// - Parameters:
  ///   - center: The anchor to rotate around.
  ///   - point: The point to rotate.
  /// - Returns: The rotated point rounded with 2 decimal places.
  func rotateMetersToLatLng(center: CGPoint, point: CGPoint) -> CGPoint {
    CGPoint(x:
              round(value:
                      (metersToLatLngConstants.rotate.cos * (point.x - center.x)) -
                      (metersToLatLngConstants.rotate.sin * (point.y - center.y)) +
                      center.x),
            y:
              round(value:
                      (metersToLatLngConstants.rotate.cos * (point.y - center.y)) +
                      (metersToLatLngConstants.rotate.sin * (point.x - center.x)) +
                      center.y)
    )
  }

  /// Rounds the given value to
  /// 2 decimal places. Math.round
  /// rounds 0.1 to 0, 0.5 to 1 and
  /// 0.9 to 1.
  ///
  /// Worth noting is that swift will
  /// in some casses hold numbers
  /// such as 64.54 as the number
  /// 64.540000000000006 (even if you
  /// define the value without using
  /// this function) causing a different
  /// outcome compared to Android &
  /// javascript.
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
  func determineLatLngToMetersX(longitude: Double) -> Double {
    let lambda = degreesToRadians(degrees: longitude)
    let dlambda = lambda - latLngToMetersConstants.origin.lambda
    let cosDl = cos(dlambda)
    let sinDl = sin(dlambda)
    let numerator = sqrt(
      (latLngToMetersConstants.origin.cosSquare * pow(sinDl, 2)) +
      pow((latLngToMetersConstants.origin.cosSin -
           (latLngToMetersConstants.origin.cosSin * cosDl)), 2)
    )

    let denominator = latLngToMetersConstants.origin.sinSquare + (latLngToMetersConstants.origin.cosSquare * cosDl)
    // Spherical special case of Vincenty's formulae
    let dsigma = atan2(numerator, denominator) * dlambda.sign()
    return earthRadiusInMeters * dsigma
  }

  /// Determines the meter y value
  /// for the given latitude.
  /// - Parameter latitude: The value to convert.
  /// - Returns: The meter y value.
  func determineLatLngToMetersY(latitude: Double) -> Double {
    let theta = degreesToRadians(degrees: latitude)
    let dtheta = theta - latLngToMetersConstants.origin.theta
    let cos = cos(theta)
    let sin = sin(theta)
    let numerator = sqrt(
      pow(cos * latLngToMetersConstants.y.sinDl, 2) +
      pow((latLngToMetersConstants.origin.cos * sin) -
          (latLngToMetersConstants.y.cosDlSin * cos), 2)
    )

    let denominator = (latLngToMetersConstants.origin.sin * sin) + (latLngToMetersConstants.y.cosDlCos * cos)
    // Spherical special case of Vincenty's formulae
    let dsigma = atan2(numerator, denominator) * dtheta.sign()
    return earthRadiusInMeters * dsigma
  }
}

/// Extends the RealCoordinateConverter with
/// the ICoordinateConverterReal protocol
/// functionality.
extension RealCoordinateConverter: ICoordinateConverterReal {
  public func latLngToMeters(coordinate: CLLocationCoordinate2D) -> CGPoint {
    rotateLatLngToMeters(
      center: meterOrigin,
      point: CGPoint(
        x: determineLatLngToMetersX(longitude: coordinate.longitude),
        y: determineLatLngToMetersY(latitude: coordinate.latitude)
      ))
  }

  public func metersToLatLng(point: CGPoint) -> CLLocationCoordinate2D {
    // rotate meterPoint using angle
    let mPoint = rotateMetersToLatLng(center: meterOrigin, point: point)
    let distanceInMeters = pythagorean(xDiff: mPoint.x, yDiff: mPoint.y)
    // bearing: vector angle
    let bearing = atan2(Double(mPoint.x), Double(mPoint.y))
    let newLatitude = asin(
      sin(metersToLatLngConstants.latitude) * cos(distanceInMeters / earthRadiusInMeters) +
      cos(metersToLatLngConstants.latitude) * sin(distanceInMeters / earthRadiusInMeters) *
      cos(bearing)
    )

    let newLongitude = metersToLatLngConstants.longitude + atan2(
      sin(bearing) * sin(distanceInMeters / earthRadiusInMeters) * cos(newLatitude),
      cos(distanceInMeters / earthRadiusInMeters) - pow(sin(newLatitude), 2)
    )
    return CLLocationCoordinate2D(
      latitude: radiansToDegrees(radians: newLatitude),
      longitude: radiansToDegrees(radians: newLongitude)
    )
  }

  public func metersToPixels(point: CGPoint) -> CGPoint {
    point.multiply(value: pixelsPerMeter)
  }

  public func pixelsToMeters(point: CGPoint) -> CGPoint {
    point.divide(value: pixelsPerMeter)
  }
}
