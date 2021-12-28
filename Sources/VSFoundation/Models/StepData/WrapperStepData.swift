//
// WrapperStepData
// VSEngineWrapper
//
// Created by Hripsime on 2021-12-28
// Copyright Virtual Stores - 2021
//
import Foundation

public struct WrapperStepData {
    public let speed: Float
    public let direction: Double
    public let duration: Int64
    public let currentTime: Int64
    public let orientation: DeviceOrientation
    
    public init(speed: Float, direction: Double, duration: Int64, currentTime: Int64, orientation: DeviceOrientation) {
        self.speed = speed
        self.direction = direction
        self.duration = duration
        self.currentTime = currentTime
        self.orientation = orientation
    }
}
