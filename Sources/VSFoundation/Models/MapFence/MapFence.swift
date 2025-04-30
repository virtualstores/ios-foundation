//
// MapFence.swift
// PositionKit
//
// Created by Emil Bond on 2020-08-18.
//
import Foundation
#if canImport(UIKit)
import UIKit

// Code specific to platforms where UIKit is available
public struct MapFence: Codable {
  public let type: String
  public let properties: Properties
  public let coordinates: [[[[Double]]]]

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.type = try container.decode(String.self, forKey: .type)
    self.properties = try container.decode(Properties.self, forKey: .properties)
    self.coordinates = try container.decode([[[[Double]]]].self, forKey: .coordinates)
  }

  public init(properties: Properties, coordinates: [[[[Double]]]]) {
    self.type = "MultiPolygon"
    self.properties = properties
    self.coordinates = coordinates
  }
  
  public struct Properties: Codable {
    public let width, height: Double

    public init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.width = try container.decode(Double.self, forKey: .width)
      self.height = try container.decode(Double.self, forKey: .height)
    }

    public init(width: Double, height: Double) {
      self.width = width
      self.height = height
    }
  }
}
#endif
