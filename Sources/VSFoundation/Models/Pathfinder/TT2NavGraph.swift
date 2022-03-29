//
//  TT2NavGraph.swift
//  
//
//  Created by Théodore Roos on 2022-03-29.
//

import Foundation

public class TT2NavGraph {
  public let spacing: Double
  public let numVertices: Int32
  public let vertices: [String : Vertex]

  public init(spacing: Double, numVertices: Int32, vertices: [String : Vertex]) {
    self.spacing = spacing
    self.numVertices = numVertices
    self.vertices = vertices
  }

  public class Vertex {
    public let id: String
    public let x: Float
    public let y: Float
    public let cost: Int32
    public let neighborCosts: [String : Int32]

    public init(id: String, x: Float, y: Float, cost: Int32, neighborCosts: [String : Int32]) {
      self.id = id
      self.x = x
      self.y = y
      self.cost = cost
      self.neighborCosts = neighborCosts
    }
  }
}
