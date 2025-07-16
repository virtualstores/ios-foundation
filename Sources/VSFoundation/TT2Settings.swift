//
//  TT2Settings.swift
//  VSFoundation
//
//  Created by Théodore Roos on 2025-04-15.
//

public struct TT2Settings {
  public let engine: TT2Engine
  public let params: TT2ModelParams
  public let isAutomaticFloorChangeEnabled: Bool
  public let saveToDiskEnabled: Bool
  public let offlineModeEnabled: Bool
  public let debugModeEnabled: Bool
  public let extendedDebugModeEnabled: Bool

  public init(
    engine: TT2Engine = .indoor,
    params: TT2ModelParams = .init(),
    isAutomaticFloorChangeEnabled: Bool = true,
    saveToDiskEnabled: Bool = false,
    offlineModeEnabled: Bool = false,
    //debugModeEnabled: Bool = false,
    //extendedDebugModeEnabled: Bool = false
  ) {
    self.engine = engine
    self.params = params
    self.isAutomaticFloorChangeEnabled = isAutomaticFloorChangeEnabled
    self.saveToDiskEnabled = saveToDiskEnabled
    self.offlineModeEnabled = offlineModeEnabled
    self.debugModeEnabled = false// debugModeEnabled
    self.extendedDebugModeEnabled = false// debugModeEnabled ? extendedDebugModeEnabled : false
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
