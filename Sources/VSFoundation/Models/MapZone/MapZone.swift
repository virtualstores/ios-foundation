import Foundation
import CoreGraphics

import Foundation
import CoreGraphics
import CoreLocation

public struct ZoneData {
  public let mapZones: [MapZone]
  public let mapZonesPoints: [MapZoneCoordinate]
  public let sharedProperties: SharedZoneProperties?

  public init(mapZones: [MapZone], mapZonesPoints: [MapZoneCoordinate], sharedProperties: SharedZoneProperties?) {
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

public struct MapZoneCoordinate {
  public let name: String
  public let coordinate: CLLocationCoordinate2D
  public let parentId: String?

  public init(name: String, coordinate: CLLocationCoordinate2D, parentId: String?) {
    self.name = name
    self.coordinate = coordinate
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
  public let fillAlpha: Double?

  public let lineColor: String?
  public let lineColorSelected: String?
  public let lineOpacity: Double?
  public let lineWidth: Double?

  public let textColor: String?
  public let textColorSelected: String?
  public let textSize: Double?
  public let textOpacity: Double?
  public let textAllowOverLap: Bool?
  public let textAnchor: String?
  public let textIgnorePlacement: Bool?

  public init(
    description: String? = nil,
    id: String,
    name: String,
    names: [String] = [],
    parentId: String? = nil,
    fillColor: String? = nil,
    fillColorSelected: String? = nil,
    fillAlpha: Double? = nil,
    lineColor: String? = nil,
    lineColorSelected: String? = nil,
    lineOpacity: Double? = nil,
    lineWidth: Double? = nil,
    textColor: String? = nil,
    textColorSelected: String? = nil,
    textSize: Double? = nil,
    textOpacity: Double? = nil,
    textAllowOverLap: Bool? = nil,
    textAnchor: String? = nil,
    textIgnorePlacement: Bool? = nil
  ) {
    self.description = description
    self.id = id
    self.name = name
    self.names = names
    self.parentId = parentId

    self.fillColor = fillColor
    self.fillColorSelected = fillColorSelected
    self.fillAlpha = fillAlpha

    self.lineColor = lineColor
    self.lineColorSelected = lineColorSelected
    self.lineOpacity = lineOpacity
    self.lineWidth = lineWidth

    self.textColor = textColor
    self.textColorSelected = textColorSelected
    self.textSize = textSize
    self.textOpacity = textOpacity
    self.textAllowOverLap = textAllowOverLap
    self.textAnchor = textAnchor
    self.textIgnorePlacement = textIgnorePlacement
  }
}

public struct SharedZoneProperties {
  public let fillColor: String?
  public let fillColorSelected: String?
  public let fillAlpha: Double?

  public let lineColor: String?
  public let lineColorSelected: String?
  public let lineOpacity: Double?
  public let lineWidth: Double?

  public let textColor: String?
  public let textColorSelected: String?
  public let textSize: Double?
  public let textOpacity: Double?
  public let textAllowOverLap: Bool?
  public let textAnchor: String?
  public let textIgnorePlacement: Bool?

  public init(
    fillColor: String? = nil,
    fillColorSelected: String? = nil,
    fillAlpha: Double? = nil,
    lineColor: String? = nil,
    lineColorSelected: String? = nil,
    lineOpacity: Double? = nil,
    lineWidth: Double? = nil,
    textColor: String? = nil,
    textColorSelected: String? = nil,
    textSize: Double? = nil,
    textOpacity: Double? = nil,
    textAllowOverLap: Bool? = nil,
    textAnchor: String? = nil,
    textIgnorePlacement: Bool? = nil
  ) {
    self.fillColor = fillColor
    self.fillColorSelected = fillColorSelected
    self.fillAlpha = fillAlpha

    self.lineColor = lineColor
    self.lineColorSelected = lineColorSelected
    self.lineOpacity = lineOpacity
    self.lineWidth = lineWidth

    self.textColor = textColor
    self.textColorSelected = textColorSelected
    self.textSize = textSize
    self.textOpacity = textOpacity
    self.textAllowOverLap = textAllowOverLap
    self.textAnchor = textAnchor
    self.textIgnorePlacement = textIgnorePlacement
  }
}
