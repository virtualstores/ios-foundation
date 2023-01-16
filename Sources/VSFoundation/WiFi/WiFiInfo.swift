//
//  WiFiInfo.swift
//  
//
//  Created by Théodore Roos on 2022-09-01.
//

import Foundation

public struct WiFiInfo {
  public let bssid: String
  public let ssid: String
  public let signalStrength: Double

  public init(bssid: String, ssid: String, signalStrength: Double) {
    self.bssid = bssid
    self.ssid = ssid
    self.signalStrength = signalStrength
  }
}
