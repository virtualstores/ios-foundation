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
