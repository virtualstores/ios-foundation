//
//  File.swift
//  
//
//  Created by Théodore Roos on 2023-05-29.
//

import Foundation
import CoreML

public protocol VPSModelManager {
  var model: MLModel? { get }
  var params: VPSModelParams? { get }
}

public struct VPSModelParams {
  public let frameSize: Int32
  public let useSmooting: Bool

  public init(frameSize: Int32, useSmooting: Bool) {
    self.frameSize = frameSize
    self.useSmooting = useSmooting
  }
}
