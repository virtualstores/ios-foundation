//
//  User.swift
//  PassiveDemoApp
//
//  Created by Hripsime on 2022-03-07.
//

import Foundation

final public class User {
    public var id: String?
    public var userId: String?
    public var height: Float?
    public var name: String?
    public var age: String?
    public var gender: String?
    
    public init(id: String?, userId: String?, height: Float?, name: String?, age: String?, gender: String?) {
        self.id = id
        self.userId = userId
        self.height = height
        self.name = name
        self.age = age
        self.gender = gender
    }
}

public struct MlUser {
  public let speedModifier: [DeviceOrientation: Double]
  public let directionModifier: [DeviceOrientation: Double]
  public let mlAlgorithm: PersonalMLAlgorithm

  public init(speedModifier: [DeviceOrientation : Double], directionModifier: [DeviceOrientation : Double], mlAlgorithm: PersonalMLAlgorithm) {
    self.speedModifier = speedModifier
    self.directionModifier = directionModifier
    self.mlAlgorithm = mlAlgorithm
  }
}
