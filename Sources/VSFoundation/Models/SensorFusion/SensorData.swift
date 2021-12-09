// SensorData
// VSFoundation
//
// Created by CJ on 2021-11-26
// Copyright Virtual Stores - 2021
//

import Foundation

public struct SensorData {

    public let type: SensorDataType
    public let data: [Double]
    public let timestampSensor: Int
    public let timestampLocal: Int

    public init(type: SensorDataType, data: [Double], timestampSensor: Int, timestampLocal: Int) {
        self.type = type
        self.data = data
        self.timestampSensor = timestampSensor
        self.timestampLocal = timestampLocal
    }
}

public enum SensorDataType {
    case acceleration
    case gravity
    case rotation
}
