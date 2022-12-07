//
//  IUserController.swift
//  
//
//  Created by Théodore Roos on 2022-12-06.
//

import Foundation

public protocol IUserController {
  func getVPSSettings() -> VPSSettings
  func getVPSMLParamPackage(mlAlgorithm: PersonalMLAlgorithm) -> [PersonalMLDataDTO]
}

public struct VPSSettings {
  public let mlAlgos: [PersonalMLAlgorithm]? //= [.coefficientOptimizer]
  public let useML: Bool //= true
  public let mlAlgo: PersonalMLAlgorithm //= .coefficientOptimizer

  public init(mlAlgos: [PersonalMLAlgorithm]?, useML: Bool, mlAlgo: PersonalMLAlgorithm) {
    self.mlAlgos = mlAlgos
    self.useML = useML
    self.mlAlgo = mlAlgo
  }
}
