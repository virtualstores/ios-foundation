// MotionSensorData
// VSFoundation
//
// Created by CJ on 2021-11-26
// Copyright Virtual Stores - 2021
//

import Foundation

public struct MotionSensorData {
    public let timestampSensor: Int
    public let timestampLocal: Int

    public let acceleration: SensorData
    public let gravity: SensorData
    public let rotation: SensorData

    public init(timestampSensor: Int, timestampLocal: Int, accelerationData: [Double], gravityData: [Double], rotationData: [Double]) {
        self.timestampSensor = timestampSensor
        self.timestampLocal = timestampLocal
        self.acceleration = SensorData(type: .acceleration, data: accelerationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.gravity = SensorData(type: .gravity, data: gravityData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.rotation = SensorData(type: .rotation, data: rotationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    }
}
