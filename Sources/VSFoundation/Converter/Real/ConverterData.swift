//
//  ConverterData.swift
//
//
//  Created by Théodore Roos on 2023-11-09.
//

import Foundation

struct Rotate {
  let cos: Double
  let sin: Double
}

struct LatLngToMetersConstants {
  let origin: Origin
  let y: Y
  let rotate: Rotate

  struct Origin {
    let lambda: Double
    let theta: Double
    let cos: Double
    let sin: Double
    let cosSquare: Double
    let sinSquare: Double
    let cosSin: Double
  }

  struct Y {
    let cosDlCos: Double
    let cosDlSin: Double
    let sinDl: Double
  }
}

struct MetersToLatLngConstants {
  let longitude: Double
  let latitude: Double
  let rotate: Rotate
}
