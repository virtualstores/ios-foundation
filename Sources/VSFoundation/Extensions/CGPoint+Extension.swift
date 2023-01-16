//
//  File.swift
//  
//
//  Created by Hripsime on 2022-02-13.
//

import Foundation
import CoreGraphics
import CoreLocation

public extension CGPoint {
    func fromMeterToPixel(converter: ICoordinateConverter) -> CGPoint {
        let x = converter.convertFromMetersToPixels(input: self.x)
        let y = converter.convertFromMetersToPixels(input: self.y)
        
        return CGPoint(x: x, y: y)
    }
    
    func fromPixelToLatLng(converter: ICoordinateConverter) -> CLLocationCoordinate2D {
        let x = converter.convertFromPixelsToMapCoordinate(input: self.x)
        let y = converter.convertFromPixelsToMapCoordinate(input: self.y)
        
        return CLLocationCoordinate2D(latitude: y, longitude: x)
    }
    
    func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CLLocationCoordinate2D {
        let pixelPoint = self.fromMeterToPixel(converter: converter)
        let converted = pixelPoint.fromPixelToLatLng(converter: converter)
        return converted
    }

    func flipY(converter: ICoordinateConverter) -> CGPoint {
        CGPoint(x: x, y: converter.heightInPixels - y)
    }

    func distance(to point: CGPoint) -> Double {
        sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

public extension CLLocationCoordinate2D {
    func fromLatLngToMeter(converter: ICoordinateConverter) -> CGPoint {
        let x = converter.convertFromMapCoordinateToMeters(input: longitude)
        let y = converter.convertFromMapCoordinateToMeters(input: latitude)
        return CGPoint(x: x, y: y)
    }
}
