import Foundation
import CoreGraphics

import Foundation
import CoreGraphics

public struct ZoneData {
  public let mapZones: [MapZone]
  public let mapZonesPoints: [MapZonePoint]
  public let sharedProperties: SharedZoneProperties?

  public init(mapZones: [MapZone], mapZonesPoints: [MapZonePoint], sharedProperties: SharedZoneProperties?) {
    self.mapZones = mapZones
    self.mapZonesPoints = mapZonesPoints
    self.sharedProperties = sharedProperties
  }
}

public struct MapZone {
  public let id: String
  public let zone: [CGPoint]
  public let properties: ZoneProperties

  public init(id: String, zone: [CGPoint], properties: ZoneProperties) {
    self.id = id
    self.zone = zone
    self.properties = properties
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

public struct ZoneProperties {
  public let description: String?
  public let id: String
  public let name: String
  public let names: [String]
  public let parentId: String?
  public let fillColor: String?
  public let fillColorSelected: String?
  public let lineColor: String?
  public let lineColorSelected: String?

  public init(
    description: String? = nil,
    id: String,
    name: String,
    names: [String] = [],
    parentId: String? = nil,
    fillColor: String? = nil,
    fillColorSelected: String? = nil,
    lineColor: String? = nil,
    lineColorSelected: String? = nil
  ) {
    self.description = description
    self.id = id
    self.name = name
    self.names = names
    self.parentId = parentId
    self.fillColor = fillColor
    self.fillColorSelected = fillColorSelected
    self.lineColor = lineColor
    self.lineColorSelected = lineColorSelected
  }
}

public struct SharedZoneProperties {
  public let fillColor: String?
  public let fillColorSelected: String?
  public let lineColor: String?
  public let lineColorSelected: String?
  public let textColor: String?
  public let textColorSelected: String?

  public init(
    fillColor: String?,
    fillColorSelected: String?,
    lineColor: String?,
    lineColorSelected: String?,
    textColor: String?,
    textColorSelected: String?
  ) {
    self.fillColor = fillColor
    self.fillColorSelected = fillColorSelected
    self.lineColor = lineColor
    self.lineColorSelected = lineColorSelected
    self.textColor = textColor
    self.textColorSelected = textColorSelected
  }
}
