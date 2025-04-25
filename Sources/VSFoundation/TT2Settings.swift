//
//  TT2Settings.swift
//  VSFoundation
//
//  Created by Théodore Roos on 2025-04-15.
//

public struct TT2Settings {
  public let engine: TT2Engine
  public let params: TT2ModelParams
  public let isAutomaticFloorChangeEanbled: Bool

  public init(engine: TT2Engine = .indoor, params: TT2ModelParams = .init(), isAutomaticFloorChangeEanbled: Bool = true) {
    self.engine = engine
    self.params = params
    self.isAutomaticFloorChangeEanbled = isAutomaticFloorChangeEanbled
  }

  public enum TT2Engine: String {
    case gpsFusion = "GPS_FUSION"
    case indoor = "INDOOR"
    case noMap = "NO_MAP"
    case openTerrain = "OPEN_TERRAIN"
  }

  public struct TT2ModelParams {
    public let target: Int
    public let targetMLModelVersion: Int?
    public let targetNLModelVersion: Int?

    public init(target: Int = 1, targetMLModelVersion: Int? = nil, targetNLModelVersion: Int? = nil) {
      self.target = target
      self.targetMLModelVersion = targetMLModelVersion
      self.targetNLModelVersion = targetNLModelVersion
    }
  }
}
