//
// DeviceInformation
// VSTT2
//
// Created by Hripsime on 2022-01-12
// Copyright Virtual Stores - 2021

import Foundation

public struct DeviceInformation: Codable {
    public let id: String
    public let operatingSystem: String
    public let osVersion: String
    public let appVersion: String
    public let deviceModel: String
    
    public init(
        id: String,
        operatingSystem: String,
        osVersion: String,
        appVersion: String,
        deviceModel: String
    ) {
        self.id = id
        self.operatingSystem = operatingSystem
        self.osVersion = osVersion
        self.appVersion = appVersion
        self.deviceModel = deviceModel
    }
}
