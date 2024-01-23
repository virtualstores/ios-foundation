//
//  MLProcessedPath.swift
//  
//
//  Created by Théodore Roos on 2023-12-15.
//

import Foundation
import CoreGraphics

public struct MLProcessedPath {
  public let path: [CGPoint]
  public let angleCorrection: Double
  public let speedAdjustment: Double

  public init(path: [CGPoint], angleCorrection: Double, speedAdjustment: Double) {
    self.path = path
    self.angleCorrection = angleCorrection
    self.speedAdjustment = speedAdjustment
  }
}
