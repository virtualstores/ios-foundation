// Double+CollectionFunctions.swift
// VSFoundation
//
// Created by CJ on 2021-12-15
// Copyright Virtual Stores - 2021
//

import Foundation

public extension Array where Element == Double {
  var asMatrix: [[Double]] {
    [
      [self[0], self[1], self[2]],
      [self[3], self[4], self[5]],
      [self[6], self[7], self[8]]
    ]
  }

  func changeSign() -> [Double] {
    self.map { -1.0 * $0 }
  }

  func quaternionInverse() -> [Double] {
    let qw = self[3]
    let qx = self[0]
    let qy = self[1]
    let qz = self[2]
    let norm = pow(qw, 2) + pow(qx, 2) + pow(qy, 2) + pow(qz, 2)
    let tw = qw / norm
    let tx = -qx / norm
    let ty = -qy / norm
    let tz = -qz / norm
    return [tx, ty, tz, tw]
  }

  func multiplyQuaternion(quaternionDerivative: [Double]) -> [Double] {
    let qw = self[3]
    let qx = self[0]
    let qy = self[1]
    let qz = self[2]
    let pw = quaternionDerivative[3]
    let px = quaternionDerivative[0]
    let py = quaternionDerivative[1]
    let pz = quaternionDerivative[2]
    let tw = pw * qw - px * qx - py * qy - pz * qz
    let tx = pw * qx + px * qw - py * qz + pz * qy
    let ty = pw * qy + px * qz + py * qw - pz * qx
    let tz = pw * qz - px * qy + py * qx + pz * qw
    return [tx, ty, tz, tw]
  }

  func norm() -> Double {
    var ret = 0.0
    forEach {
      ret += $0 * $0
    }
    return sqrt(ret)
  }

  static func compareArraysUpToTolerance(array1: [Double], array2: [Double], tolerance: Double) -> Bool {
    // print(array1)
    // print(array2)
    if (array1.count != array2.count) {
      print("mismatched counts")
      return false
    }
    for i in array1.indices {
      if (array1[i] != 0) {
        if (abs(array1[i] - array2[i]) / (abs(array1[i])) > tolerance) {
          print("Array 1: ", array1)
          print("Array 2: ", array2)
          return false
        }
      } else { // this is not perfect but I can't be bothered right now
        if (abs(array1[i] - array2[i]) > tolerance) {
          return false
        }
      }
    }
    return true
  }
}
