// MotionSensorData
// VSFoundation
//
// Created by CJ on 2021-11-26
// Copyright Virtual Stores - 2021
//

import Foundation
import CoreMotion

public struct MotionSensorData {
    public let timestampSensor: Int
    public let timestampLocal: Int
    public let timestampLocalNano: UInt64

    public let acceleration: SensorData
    public let gravity: SensorData
    public let rotation: SensorData
    public let gyroscope: SensorData
    public let accelerometer: SensorData
    public let magnetometer: SensorData

    public init(timestampSensor: Int, timestampLocal: Int, timestampLocalNano: UInt64, accelerationData: [Double], gravityData: [Double], rotationData: [Double], rotationRateData: [Double], accelerometerData: [Double], magnetometerData: [Double]) {
        self.timestampSensor = timestampSensor
        self.timestampLocal = timestampLocal
        self.timestampLocalNano = timestampLocalNano
        self.acceleration = SensorData(type: .acceleration, data: accelerationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.gravity = SensorData(type: .gravity, data: gravityData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.rotation = SensorData(type: .rotation, data: rotationData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.gyroscope = SensorData(type: .gyroscope, data: rotationRateData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.accelerometer = SensorData(type: .accelerometer, data: accelerometerData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
        self.magnetometer = SensorData(type: .magnetometer, data: magnetometerData, timestampSensor: timestampSensor, timestampLocal: timestampLocal)
    }
}

public extension MotionSensorData {
    private static var gravity: Double { 9.81 }

    init(data: CMDeviceMotion, accelerometerData: CMAccelerometerData?, magnetometerData: CMMagnetometerData?) {
        let gravity = Self.gravity

        let timestampSensor = Int(data.timestamp * 1000)
        let timestampLocal = Date().currentTimeMillis
        let timestampLocalNano: UInt64 = .nanoTime

        let accelerationData = [data.userAcceleration.x * gravity,
                                data.userAcceleration.y * gravity,
                                data.userAcceleration.z * gravity]

        let gravityData = [data.gravity.x * -gravity,
                           data.gravity.y * -gravity,
                           data.gravity.z * -gravity]

        let rotationData = [data.attitude.quaternion.x,
                            data.attitude.quaternion.y,
                            data.attitude.quaternion.z,
                            data.attitude.quaternion.w]

        let rotationRateData = [data.rotationRate.x,
                            data.rotationRate.y,
                            data.rotationRate.z]

        let accelerometerData = [accelerometerData?.acceleration.x,
                                 accelerometerData?.acceleration.y,
                                 accelerometerData?.acceleration.z]
                                  .compactMap { $0 }
                                  .map { $0 * gravity }

        let magnetometerData = [magnetometerData?.magneticField.x,
                                magnetometerData?.magneticField.y,
                                magnetometerData?.magneticField.z].compactMap { $0 }


        self.init(timestampSensor: timestampSensor,
                  timestampLocal: timestampLocal,
                  timestampLocalNano: timestampLocalNano,
                  accelerationData: accelerationData,
                  gravityData: gravityData,
                  rotationData: rotationData,
                  rotationRateData: rotationRateData,
                  accelerometerData: accelerometerData,
                  magnetometerData: magnetometerData
        )
    }
}
