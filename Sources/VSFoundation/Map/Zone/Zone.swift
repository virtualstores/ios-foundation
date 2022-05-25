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
    public private(set) var properties: ZoneProperties
    public let floorLevelId: Int64
    public private(set) var color: UIColor = .white
    public private(set) var image: UIImage?
    public private(set) var polygon: [CGPoint]
    public var parent: Zone?
    public private(set) var children: Dictionary<String, Zone>
    public private(set) var navigationPoint: CGPoint?

    public var name: String { properties.name }
    public var searchTerms: [String] { properties.names }

    private let converter: BaseCoordinateConverter

    private var bezierPath: UIBezierPath?

    public init(id: String, properties: ZoneProperties, polygon: [CGPoint] = [], navigationPoint: CGPoint? = nil, parent: Zone? = nil, children: Dictionary<String, Zone> = [:], floorLevelId: Int64, converter: BaseCoordinateConverter) {
        self.id = id
        self.properties = properties
        self.polygon = polygon
        self.navigationPoint = navigationPoint
        self.parent = parent
        self.children = children
        self.floorLevelId = floorLevelId
        self.converter = converter
    }
    
    public var points: [CGPoint] {
        var points: [CGPoint] = []
        for point in polygon {
            points.append(CGPoint(x: converter.convertFromMapCoordinateToMeters(input: point.x), y: converter.convertFromMapCoordinateToMeters(input: point.y)))
        }
        return points
    }
    
    public func addChild(child: Zone) {
        let zone = Zone(id: child.id, properties: child.properties, polygon: child.polygon, navigationPoint: child.navigationPoint, parent: self, floorLevelId: child.floorLevelId, converter: converter)
        self.children[child.name] = zone
    }
    
    public func getChildren() -> [Zone]? {
        var list: [Zone] = []
        
        list.append(self)
        
        for key in self.children.keys {
            if let zones = self.children[key]?.getChildren() {
                list += zones
            }
        }
        
        return !list.isEmpty ? list : nil
    }
    
    public func recursivePrint(_ padding: String) {
        Logger.init(verbosity: .debug).log(message: "\(padding)\(self.name)")
        
        for key in self.children.keys {
            self.children[key]?.recursivePrint(padding + "    ")
        }
    }
    
    public func recursiveSearch(_ searchString: String) -> [Zone]? {
        var list: [Zone] = []
        
        var search: String = self.name
        
        for string in searchTerms {
            search = search + ":" + string
        }
        
        if search.lowercased().contains(searchString.lowercased()) {
            list.append(self)
        }
        
        for key in self.children.keys {
            if let zones = self.children[key]?.recursiveSearch(searchString) {
                list += zones
            }
        }
        
        return !list.isEmpty ? list : nil
    }
    
    func contains(point: CGPoint) -> Bool {
        if self.bezierPath == nil {
            guard points.count > 0 else {
                return false
            }
            
            let path = UIBezierPath()
            path.move(to: points[0])
            for point in points {
                path.addLine(to: point)
            }
            path.close()
            self.bezierPath = path
        }
        
        guard let path = self.bezierPath else {
            return false
        }
        
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
}
