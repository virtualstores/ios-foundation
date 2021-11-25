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
    
    
    public init(type: SensorDataType, data: [Float]){
        self.type = type
        self.data = data
    }
}

public enum SensorDataType{
    case acceleration
    case gravity
    case rotation
}
