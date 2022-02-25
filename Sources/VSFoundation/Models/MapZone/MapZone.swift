import Foundation
import CoreGraphics

import Foundation
import CoreGraphics

public struct MapZone {
    public let id: String
    public let name: String
    public let zone: [CGPoint]
    public let parentId: String?
    public let description: String?
    
    public init(id: String, name: String, zone: [CGPoint], parentId: String?, description: String?) {
        self.id = id
        self.name = name
        self.zone = zone
        self.parentId = parentId
        self.description = description
    }
}

public struct MapZonePoint {
    public let name: String
    public let point: CGPoint
    public let parentId: String?
    
    public init(name: String, point: CGPoint, parentId: String?) {
        self.name = name
        self.point = point
        self.parentId = parentId
    }
}
