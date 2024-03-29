//
//  CoreGraphics+CoreLocation+Extension.swift
//  
//
//  Created by Hripsime on 2022-02-13.
//

import CoreLocation

public extension CGPoint {
    var asArray: [Double] { [x, y] }

    func fromMeterToPixel(converter: ICoordinateConverter) -> CGPoint {
        let x = converter.convertFromMetersToPixels(input: x)
        let y = converter.convertFromMetersToPixels(input: y)
        return CGPoint(x: x, y: y)
    }
    
    func fromPixelToLatLng(converter: ICoordinateConverter) -> CLLocationCoordinate2D {
        let x = converter.convertFromPixelsToMapCoordinate(input: x)
        let y = converter.convertFromPixelsToMapCoordinate(input: y)
        return CLLocationCoordinate2D(latitude: y, longitude: x)
    }

    func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CLLocationCoordinate2D {
        fromMeterToPixel(converter: converter).fromPixelToLatLng(converter: converter)
    }

    func convertFromMeterToLatLng(converter: ICoordinateConverterReal) -> CLLocationCoordinate2D {
        converter.metersToLatLng(point: self)
    }

    func fromMeterToPixel(converter: ICoordinateConverterReal) -> CGPoint {
        converter.metersToPixels(point: self)
    }

    func fromPixelsToMeter(converter: ICoordinateConverterReal) -> CGPoint {
        converter.pixelsToMeters(point: self)
    }

    func flipY(converter: ICoordinateConverter) -> CGPoint {
        CGPoint(x: x, y: converter.heightInPixels - y)
    }

    func distance(to point: CGPoint) -> Double {
        sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }

    func add(point: CGPoint) -> CGPoint {
        add(x: point.x, y: point.y)
    }

    func add(x: Double, y: Double) -> CGPoint {
        CGPoint(x: self.x + x, y: self.y + y)
    }

    func multiply(value: Double) -> CGPoint {
        CGPoint(x: x * value, y: y * value)
    }

    func divide(value: Double) -> CGPoint {
        CGPoint(x: x / value, y: y / value)
    }
}

public extension CGSize {
  func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CGSize {
    CGSize(
      width: converter.convertFromMetersToMapCoordinate(input: width),
      height: converter.convertFromMetersToMapCoordinate(input: height)
    )
  }
}

public extension CGRect {
    func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CGRect {
      let origin = CGPoint(x: converter.convertFromMetersToMapCoordinate(input: minX), y: converter.convertFromMetersToMapCoordinate(input: minY))
      let size = size.convertFromMeterToLatLng(converter: converter)
      return CGRect(origin: origin, size: size)
    }
}

public extension CLLocationCoordinate2D {
    func fromLatLngToMeter(converter: ICoordinateConverter) -> CGPoint {
        let x = converter.convertFromMapCoordinateToMeters(input: longitude)
        let y = converter.convertFromMapCoordinateToMeters(input: latitude)
        return CGPoint(x: x, y: y)
    }

    func fromLatLngToMeter(converter: ICoordinateConverterReal) -> CGPoint {
        converter.latLngToMeters(coordinate: self)
    }
}

public extension CLHeading {
  /// Returns `trueHeading` if it's non-negative, and otherwise `magneticHeading`.
  var headingDirection: CLLocationDirection { trueHeading >= 0 ? trueHeading : magneticHeading }
}
