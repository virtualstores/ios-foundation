//
//  RealCoordinateConverterTest.swift
//
//
//  Created by Théodore Roos on 2023-11-13.
//

import XCTest
import CoreLocation
@testable import VSFoundation

final class RealCoordinateConverterTest: XCTestCase {
  private let latLngOrigin = CLLocationCoordinate2D(latitude: 59.35293, longitude: 17.95590)
  private let mapAngle = -55.0
  private let earthRadiusInMeters = 6378137.0
  private let pixelsPerMeter = 50.0

  func test_that_conversion_from_meter_to_latlng_and_back_again_100_000_times_gives_us_accetable_and_expected_result() {
    let converter: ICoordinateConverterReal = RealCoordinateConverter(
      latLngOrigin: latLngOrigin,
      mapAngleInDegrees: mapAngle,
      earthRadiusInMeters: earthRadiusInMeters,
      pixelsPerMeter: pixelsPerMeter
    )
    
    let convertCount = 100_000
    let originalLatLngCoordinates = originalMeterCoordinates.map({ converter.metersToLatLng(point: $0) })
    XCTAssertEqual(originalLatLngCoordinates, expectedLatLngCoordinates)
    var coordinates: Any = originalLatLngCoordinates.copy()

    for _ in 1..<convertCount - 1 {
      coordinates = (coordinates as! [CLLocationCoordinate2D]).map({ converter.latLngToMeters(coordinate: $0) })
      coordinates = (coordinates as! [CGPoint]).map({ converter.metersToLatLng(point: $0) })
    }

    coordinates = (coordinates as! [CLLocationCoordinate2D]).map({ converter.latLngToMeters(coordinate: $0) })
    XCTAssertEqual((coordinates as! [CGPoint]), m100_000ExpectedMeterCoordinates)
    coordinates = (coordinates as! [CGPoint]).map({ converter.metersToLatLng(point: $0) })
    XCTAssertEqual((coordinates as! [CLLocationCoordinate2D]), m100_000ExpectedLatLngCoordinates)
  }

  // Original meter coordinates:
  private let originalMeterCoordinates: [CGPoint] = [
    .init(x: 0.0, y: 0.0),
    .init(x: 0.0, y: 123.627),
    .init(x: 112.525, y: 123.627),
    .init(x: 112.525, y: 0.0),
    .init(x: 0.0, y: 0.0)
  ]

  // Original latLng coordinates:
  private let expectedLatLngCoordinates: [CLLocationCoordinate2D] = [
    .init(latitude: 59.35293000000001, longitude: 17.9559),
    .init(latitude: 59.35356698317859, longitude: 17.954115313635846),
    .init(latitude: 59.35439497096183, longitude: 17.95525268955188),
    .init(latitude: 59.35375806207805, longitude: 17.95703739810693),
    .init(latitude: 59.35293000000001, longitude: 17.9559)
  ]

  // 100 000 meter coordinates:
  private let m100_000ExpectedMeterCoordinates: [CGPoint] = [
    .init(x: 0.0, y: 0.0),
    .init(x: 0.0, y: 123.63),
    .init(x: 112.52, y: 123.63),
    .init(x: 112.53, y: 0.0),
    .init(x: 0.0, y: 0.0)
  ]

  // 100 000 latLng coordinates:
  private let m100_000ExpectedLatLngCoordinates: [CLLocationCoordinate2D] = [
    .init(latitude: 59.35293000000001, longitude: 17.9559),
    .init(latitude: 59.35356698317859, longitude: 17.954115313635846),
    .init(latitude: 59.35439497096183, longitude: 17.95525268955188),
    .init(latitude: 59.35375806207805, longitude: 17.95703739810693),
    .init(latitude: 59.35293000000001, longitude: 17.9559)
  ]
}

extension CLLocationCoordinate2D: Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}
