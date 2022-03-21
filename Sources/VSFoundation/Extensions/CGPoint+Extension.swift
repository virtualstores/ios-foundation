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
    
    func fromPixelToLatLng(converter: ICoordinateConverter) -> CGPoint {
        let x = converter.convertFromPixelsToMapCoordinate(input: self.x)
        let y = converter.convertFromPixelsToMapCoordinate(input: self.y)
        
        return CGPoint(x: x, y: y)
    }
    
    func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CLLocationCoordinate2D {
        let pixelPoint = self.fromMeterToPixel(converter: converter)
        let converted = pixelPoint.fromPixelToLatLng(converter: converter)
        return CLLocationCoordinate2D(latitude: converted.y, longitude: converted.x)
    }
}
