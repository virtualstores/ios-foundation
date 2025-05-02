//
//  File.swift
//  
//
//  Created by Théodore Roos on 2023-07-27.
//

import Foundation

public struct PositionServiceSettings: Codable {
  public let useML: Bool
  public let useCoefficientOptimizer: Bool
  public let useDriftCompensator: Bool
  public let boolValues: [String: Bool]?
  public let stringValues: [String: String]?
  public let stringArrayValues: [String: [String]]?
  public let intValues: [String: Int]?
  public let intArrayValues: [String: [Int]]?
  public let floatValues: [String: Float]?
  public let floatArrayValues: [String: [Float]]?

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.useML = try container.decode(Bool.self, forKey: .useML)
    self.useCoefficientOptimizer = try container.decode(Bool.self, forKey: .useCoefficientOptimizer)
    self.useDriftCompensator = try container.decode(Bool.self, forKey: .useDriftCompensator)
    self.boolValues = try container.decodeIfPresent([String : Bool].self, forKey: .boolValues)
    self.stringValues = try container.decodeIfPresent([String : String].self, forKey: .stringValues)
    self.stringArrayValues = try container.decodeIfPresent([String : [String]].self, forKey: .stringArrayValues)
    self.intValues = try container.decodeIfPresent([String : Int].self, forKey: .intValues)
    self.intArrayValues = try container.decodeIfPresent([String : [Int]].self, forKey: .intArrayValues)
    self.floatValues = try container.decodeIfPresent([String : Float].self, forKey: .floatValues)
    self.floatArrayValues = try container.decodeIfPresent([String : [Float]].self, forKey: .floatArrayValues)
  }

  public init(useML: Bool, useCoefficientOptimizer: Bool, useDriftCompensator: Bool, boolValues: [String : Bool]?, stringValues: [String : String]?, stringArrayValues: [String : [String]]?, intValues: [String : Int]?, intArrayValues: [String : [Int]]?, floatValues: [String : Float]?, floatArrayValues: [String : [Float]]?) {
    self.useML = useML
    self.useCoefficientOptimizer = useCoefficientOptimizer
    self.useDriftCompensator = useDriftCompensator
    self.boolValues = boolValues
    self.stringValues = stringValues
    self.stringArrayValues = stringArrayValues
    self.intValues = intValues
    self.intArrayValues = intArrayValues
    self.floatValues = floatValues
    self.floatArrayValues = floatArrayValues
  }
}
