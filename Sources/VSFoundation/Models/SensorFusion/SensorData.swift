//
//  File.swift
//  
//
//  Created by CJ on 2021-11-25.
//

import Foundation


public class SensorData {
    
    public let type: SensorDataType
    public let data: [Float]
    public let timestampSensor: Int
    public let timestampLocal: Int
    
    public init(type: SensorDataType, data: [Float], timestampSensor: Int, timestampLocal: Int){
        self.type = type
        self.data = data
        self.timestampSensor = timestampSensor
        self.timestampLocal = timestampLocal
    }
}

public enum SensorDataType{
    case acceleration
    case gravity
    case rotation
}
