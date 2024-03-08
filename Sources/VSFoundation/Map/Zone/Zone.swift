//
// Zone
// VSTT2
//
// Created by Hripsime on 2022-02-22
// Copyright Virtual Stores - 2022

import Foundation
import CoreGraphics
import UIKit
import CoreLocation

public class Zone: Equatable {
    public let id: String
    public let floorLevelId: Int64
    public let properties: ZoneProperties
    public let polygon: [CGPoint]
    public let navigationPoints: [String : (point: CGPoint, properties: PointProperties)]
    public private(set) var parent: Zone?
    public private(set) var children: Dictionary<String, Zone>
    public private(set) var entryPoints: [EntryPoint]

    public var navigationPoint: CGPoint? { navigationPoints.first?.value.point }
    public var navigationPointProperties: PointProperties? { navigationPoints.first?.value.properties }
    public var name: String { properties.name }
    public var names: [String] { properties.names }

    private let converter: BaseCoordinateConverter

    private var bezierPath: UIBezierPath?

    public init(id: String, floorLevelId: Int64, properties: ZoneProperties, polygon: [CGPoint] = [], navigationPoints: [String : (point: CGPoint, properties: PointProperties)] = [:], parent: Zone? = nil, children: Dictionary<String, Zone> = [:], converter: BaseCoordinateConverter) {
        self.id = id
        self.floorLevelId = floorLevelId
        self.properties = properties
        self.polygon = polygon
        self.navigationPoints = navigationPoints
        self.parent = parent
        self.children = children
        self.converter = converter
        entryPoints = []

        if let points = properties.entryPoints {
          points.forEach { (element) in
            guard
              let id = element["id"] as? String,
              let index = element["index"] as? Int,
              let point = element["point"] as? [Double],
              let angleInDegrees = element["angleInDegrees"] as? Double,
              let line = element["line"] as? [[Double]]
            else { return }
            entryPoints.append(Zone.EntryPointDto(id: id, index: index, point: point, angleInDegrees: angleInDegrees, line: line).asEntryPoint(converter: converter))
          }
        }
    }
    
    public var points: [CGPoint] {
        var points: [CGPoint] = []
        polygon.forEach { (point) in
            points.append(CGPoint(x: converter.convertFromMapCoordinateToMeters(input: point.x), y: converter.convertFromMapCoordinateToMeters(input: point.y)))
        }
        return points
    }
    
    public func addChild(child: Zone) {
        child.parent = self
        children[child.name] = child
    }
    
    public func getChildren() -> [Zone]? {
        var list: [Zone] = []
        
        list.append(self)
        
        children.keys.forEach { (key) in
            if let zones = children[key]?.getChildren() {
                list += zones
            }
        }
        
        return !list.isEmpty ? list : nil
    }
    
    public func recursivePrint(_ padding: String) {
        Logger(verbosity: .debug).log(message: "\(padding)\(name)")
        children.keys.forEach { children[$0]?.recursivePrint(padding + "    ") }
    }
    
    public func recursiveSearch(_ searchString: String) -> [Zone]? {
        var list: [Zone] = []
        
        var search: String = name

        names.forEach({ search = search + ":" + $0 })

        if search.lowercased().contains(searchString.lowercased()) {
            list.append(self)
        }
        
        for key in children.keys {
            if let zones = children[key]?.recursiveSearch(searchString) {
                list += zones
            }
        }
        
        return !list.isEmpty ? list : nil
    }
    
    func contains(point: CGPoint) -> Bool {
        if bezierPath == nil {
            guard points.count > 0 else { return false }
            let path = UIBezierPath()
            path.move(to: points[0])
            points.forEach { path.addLine(to: $0) }
            path.close()
            bezierPath = path
        }
        
        guard let path = bezierPath else { return false }
        return path.contains(point)
    }

    /// Uses name parameter for comparison
    public static func == (lhs: Zone, rhs: Zone) -> Bool {
        lhs.name == rhs.name
    }
    
    /// Uses name parameter for comparison
    public static func < (lhs: Zone, rhs: Zone) -> Bool {
        lhs.name < rhs.name
    }

    public struct EntryPointDto: Decodable {
      let id: String
      let index: Int
      let point: [Double]
      let angleInDegrees: Double
      let line: [[Double]]

      func asEntryPoint(converter: ICoordinateConverter) -> EntryPoint {
        EntryPoint(
          id: id,
          index: index,
          point: CLLocationCoordinate2D(latitude: point[1], longitude: point[0]).fromLatLngToMeter(converter: converter),
          angleInDegrees: angleInDegrees,
          line: line.map({ CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }).map({ $0.fromLatLngToMeter(converter: converter) })
        )
      }
    }

    public struct EntryPoint {
      public let id: String
      public let index: Int
      public let point: CGPoint
      public let angleInDegrees: Double
      public let line: [CGPoint]
    }
}
