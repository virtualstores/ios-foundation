//
//  IWiFiController.swift
//  
//
//  Created by Théodore Roos on 2022-09-01.
//

import Foundation
import Combine

public protocol IWiFiController {
  var wifiInfoPublisher: CurrentValueSubject<WiFiInfo?, WiFiError> { get }
  var timeInterval: Double { get }

  func add(ssid: String, passphrase: String, isWEP: Bool, completion: ((Error?) -> Void)?)

  func add(ssid: String, completion: ((Error?) -> Void)?)

  func getConfiguredSSIDs() -> [String]

  func fetch(completion: @escaping (WiFiInfo) -> Void)

  func set(timeInterval: Double)
}
