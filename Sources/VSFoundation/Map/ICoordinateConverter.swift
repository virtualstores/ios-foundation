//
//  File.swift
//  
//
//  Created by Hripsime on 2022-02-13.
//

import Foundation
import CoreLocation
import CoreGraphics

public class BaseCoordinateConverter: ICoordinateConverter {
    public var heightInMeters: Double { heightInPixels / pixelPerMeter }
    public var widthInMeters: Double { widthInPixels / pixelPerMeter }
    public var heightInPixels: Double
    public var widthInPixels: Double
    public var pixelPerMeter: Double
    private var pixelPerLatitude: Double
    private var realMetersPerLatitude: Double = 111320
    
    public init(heightInPixels: Double, widthInPixels: Double, pixelPerMeter: Double, pixelPerLatitude: Double) {
        self.heightInPixels = heightInPixels
        self.widthInPixels = widthInPixels
        self.pixelPerMeter = pixelPerMeter
        self.pixelPerLatitude = pixelPerLatitude
    }
    
    private var factor: Double {
        1000 / pixelPerMeter
    }
    
    public func convertFromPixelsToMapCoordinate(input: Double) -> Double {
        input / pixelPerLatitude
    }
    
    public func convertFromMapCoordinateToPixels(input: Double) -> Double {
        input * pixelPerLatitude
    }
    
    public func convertFromPixelsToMeters(input: Double) -> Double {
        input / pixelPerMeter
    }
    
    public func convertFromMetersToPixels(input: Double) -> Double {
        input * pixelPerMeter
    }
    
    public func convertFromMetersToMapCoordinate(input: Double) -> Double {
        return input / factor
    }
    
    public func convertFromMapCoordinateToMeters(input: Double) -> Double {
        return input * factor
    }

    public func convertFromMetersToMapMeters(input: Double) -> Double {
//        let pixels = convertFromMetersToPixels(input: input)
//        let coordinate = convertFromPixelsToMapCoordinate(input: pixels)
        return convertFromMetersToMapCoordinate(input: input) * realMetersPerLatitude
    }
}

public protocol ICoordinateConverter {
    var heightInMeters: Double { get }
    var widthInMeters: Double { get }
    var heightInPixels: Double { get }
    var widthInPixels: Double { get }
    var pixelPerMeter: Double { get }
    
    /// Will convert from pixels to  map coordinate
    func convertFromPixelsToMapCoordinate(input: Double) -> Double
    
    /// Will convert from  map coordinate to pixels
    func convertFromMapCoordinateToPixels(input: Double) -> Double
    
    /// Will convert from pixels to  map meters
    func convertFromPixelsToMeters(input: Double) -> Double
    
    /// Will convert from meters to  pixels
    func convertFromMetersToPixels(input: Double) -> Double
    
    /// Will convert from meters to  map coordinate
    func convertFromMetersToMapCoordinate(input: Double) -> Double
    
    /// Will convert from  map coordinate to meters
    func convertFromMapCoordinateToMeters(input: Double) -> Double

    func convertFromMetersToMapMeters(input: Double) -> Double
}

