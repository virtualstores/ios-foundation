// DeviceOrientation.swift
// VSSensorInterpreter

// Created by: CJ on 2021-11-26
// Copyright (c) 2021 Virtual Stores

import Foundation

public enum DeviceOrientation: String, Hashable {
  case regular = "REGULAR"
  case swingSym = "SWING_SYM"
  case swingAntiSym = "SWING_ANTI_SYM"
  case trolley = "TROLLEY"
  case trouserPocket = "TROUSER_POCKET"
  case jacketPocket = "JACKET_POCKET"
}

public enum PersonalMLAlgorithm: String, Hashable {
  case coefficientOptimizer = "COEFFICIENT_OPTIMIZER"
  case sac = "SAC"
  case heuristicNoScan = "HEURISTIC_NO_SCAN"
  case regresionMediator = "REGRESION_MEDIATOR"
  case teoScanMl = "TEO_SCAN_ML"
  case driftCompensator = "DRIFT_COMPENSATOR"
  case compassAngleRectifier = "COMPASS_ANGLE_RECTIFIER"
  case none = "NONE"
}
