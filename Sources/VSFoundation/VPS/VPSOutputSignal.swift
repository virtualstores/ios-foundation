//
//  VPSOutputSignal.swift
//  
//
//  Created by Théodore Roos on 2023-05-23.
//

import Foundation
import CoreLocation

public enum VPSOutputSignal {
  public struct Position {
    public let point: CGPoint
    public let std: Double
    public let status: Status
    public let activityState: ActivivtyState?
    public let trustedPosition: Bool
    public let timestamp: Date

    public init(point: CGPoint, std: Double, status: Status, activityState: ActivivtyState?, trustedPosition: Bool, timestamp: Date) {
      self.point = point
      self.std = std
      self.status = status
      self.activityState = activityState
      self.trustedPosition = trustedPosition
      self.timestamp = timestamp
    }

    public enum Status {
      case confident, uncertain, outOfBounds, none
    }

    public enum ActivivtyState {
      case active, idle
    }
  }

  public struct LatLngPosition {
    public let timestamp: Date
    public let mlLocation: Location
    public let gpsLocation: Location
    public let reliableSource: Source

    public init(timestamp: Date = .init(), mlLocation: Location, gpsLocation: Location, reliableSource: Source) {
      self.timestamp = timestamp
      self.mlLocation = mlLocation
      self.gpsLocation = gpsLocation
      self.reliableSource = reliableSource
    }

    public struct Location {
      public let latitude: Double
      public let longitude: Double
      public let accuracy: Double?
      public let bearing: Double?
      public let altitude: Double?
      public var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
      }

      public init(latitude: Double, longitude: Double, accuracy: Double? = nil, bearing: Double? = nil, altitude: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.accuracy = accuracy
        self.bearing = bearing
        self.altitude = altitude
      }
    }

    public enum Source {
      case gps, undefined, vpsML
    }
  }

  case position(position: Position)
  case latLng(LatLngPosition)
  case gps(LatLngPosition.Location)
  case ux(position: Position)
  case ml(position: Position)
  case rotation(heading: Double)
  case particles(positions: [CGPoint])
  case rescueMode
  case floorChange(difference: Int, timestamp: Date)
  case consistencyScoreSignal(Int)
}
