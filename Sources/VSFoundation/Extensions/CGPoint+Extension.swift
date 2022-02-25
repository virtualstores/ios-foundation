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
    
    func convertFromMeterToLatLng(converter: ICoordinateConverter) -> CGPoint {
        let pixelPoint = self.fromMeterToPixel(converter: converter)
        
        return pixelPoint.fromPixelToLatLng(converter: converter)
    }
}
