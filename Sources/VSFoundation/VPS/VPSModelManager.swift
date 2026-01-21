//
//  VPSModelManager.swift
//
//
//  Created by Théodore Roos on 2023-05-29.
//

import Foundation
import CoreML

public protocol VPSModelManager: Disposable {
  var mlModel: MLModel? { get }
  var nlModel: MLModel? { get }
  var npModel: MLModel? { get }
  var mlParams: VPSMLModelParams? { get }
  var nlParams: VPSNLModelParams? { get }
}

public struct VPSMLModelParams {
  public let frameSize: Int32
  public let useSmooting: Bool
  public let featureSequence: [VPSFeaturesEntriesEnum]
  public let stepNumberInput: Bool

  public init(frameSize: Int32, useSmooting: Bool, featureSequence: [VPSFeaturesEntriesEnum], stepNumberInput: Bool) {
    self.frameSize = frameSize
    self.useSmooting = useSmooting
    self.featureSequence = featureSequence
    self.stepNumberInput = stepNumberInput
  }
}

public struct VPSNLModelParams {
  public let resolution: Double

  public init(resolution: Double) {
    self.resolution = resolution
  }
}
