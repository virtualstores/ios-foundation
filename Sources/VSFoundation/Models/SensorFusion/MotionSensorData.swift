//
//  File.swift
//  
//
//  Created by CJ on 2021-11-25.
//

import Foundation

public class MotionSensorData {
    public let timestampSensor: Int
    public let timestampLocal: Int
    
    public let acceleration: SensorData
    public let gravity: SensorData
    public let rotation: SensorData
    
    public init(timestampSensor: Int, timestampLocal: Int, accelerationData: [Float],gravityData: [Float], rotationData: [Float] ){
        self.timestampSensor = timestampSensor
        self.timestampLocal = timestampLocal
        self.acceleration = SensorData(type: .acceleration, data: accelerationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.gravity = SensorData(type: .gravity, data: gravityData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.rotation = SensorData(type: .rotation, data: rotationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    }
}

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
