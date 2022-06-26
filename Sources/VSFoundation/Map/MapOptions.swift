//
// MapStyle.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit

public struct MapOptions {
  public struct UserMark {
    public let activeAccuracyStyle: CircleStyle
    public let staleAccuracyStyle: CircleStyle
    public let activeRadiusStyle: CircleStyle
    public let staleRadiusStyle: CircleStyle
    public let foregroundTintColor: Int?
    public let bearingTintColor: Int?
    public let backgroundTintColor: Int?
    public let minUserMarkZoomScale: Double
    public let maxUserMarkZoomScale: Double
    public let trackingAnimationDurationMultiplier: Double

    public init(
      activeAccuracyStyle: CircleStyle = CircleStyle(),
      staleAccuracyStyle: CircleStyle? = nil,
      activeRadiusStyle: CircleStyle = CircleStyle(),
      staleRadiusStyle: CircleStyle? = nil,
      foregroundTintColor: Int? = nil,
      bearingTintColor: Int? = nil,
      backgroundTintColor: Int? = nil,
      minUserMarkZoomScale: Double = 1.0,
      maxUserMarkZoomScale: Double = 4.0,
      trackingAnimationDurationMultiplier: Double = 1.0
    ) {
      self.activeAccuracyStyle = activeAccuracyStyle
      self.staleAccuracyStyle = staleAccuracyStyle ?? activeAccuracyStyle
      self.activeRadiusStyle = activeRadiusStyle
      self.staleRadiusStyle = staleRadiusStyle ?? activeRadiusStyle
      self.foregroundTintColor = foregroundTintColor
      self.bearingTintColor = bearingTintColor
      self.backgroundTintColor = backgroundTintColor
      self.minUserMarkZoomScale = minUserMarkZoomScale
      self.maxUserMarkZoomScale = maxUserMarkZoomScale
      self.trackingAnimationDurationMultiplier = trackingAnimationDurationMultiplier
    }
  }

  public struct MapMark{
    public static let BASE_TEXT_BOX_MAP_MARK_OFFSET_X: Double = 0.0
    public static let BASE_TEXT_BOX_MAP_MARK_OFFSET_Y: Double = 8.0

    public let clusteringEnabled: Bool
    public let clusterRadius: Int
    public let clusterMaxZoom: Int
    public let scaleSize: Double
    public let focusScaleSize: Double
    public let offsetX: Double
    public let offsetY: Double
    public let anchor: IconAnchor

    public enum IconAnchor: String, Codable, CaseIterable {
        /// The center of the icon is placed closest to the anchor.
        case center = "center"

        /// The left side of the icon is placed closest to the anchor.
        case left = "left"

        /// The right side of the icon is placed closest to the anchor.
        case right = "right"

        /// The top of the icon is placed closest to the anchor.
        case top = "top"

        /// The bottom of the icon is placed closest to the anchor.
        case bottom = "bottom"

        /// The top left corner of the icon is placed closest to the anchor.
        case topLeft = "top-left"

        /// The top right corner of the icon is placed closest to the anchor.
        case topRight = "top-right"

        /// The bottom left corner of the icon is placed closest to the anchor.
        case bottomLeft = "bottom-left"

        /// The bottom right corner of the icon is placed closest to the anchor.
        case bottomRight = "bottom-right"
    }

    public init (
      clusteringEnabled: Bool = true,
      clusterRadius: Int = 20,
      clusterMaxZoom: Int = 20,
      scaleSize: Double = 1.0,
      focusScaleSize: Double = 1.5,
      offsetX: Double = 0.0,
      offsetY: Double = 0.0,
      anchor: IconAnchor = .bottom
    ) {
      self.clusteringEnabled = clusteringEnabled
      self.clusterRadius = clusterRadius
      self.clusterMaxZoom = clusterMaxZoom
      self.scaleSize = scaleSize
      self.focusScaleSize = focusScaleSize
      self.offsetX = offsetX
      self.offsetY = offsetY
      self.anchor = anchor
    }
  }

  public struct MapStyle {
    public var cameraLocked: Bool {
      get {
        tiltLocked && panLocked && zoomLocked && rotationLocked
      }

      set {
        self.tiltLocked = newValue
        self.panLocked = newValue
        self.zoomLocked = newValue
        self.rotationLocked = newValue
      }
    }

    public var tiltLocked: Bool = false
    public var panLocked: Bool = false
    public var zoomLocked: Bool = false
    public var rotationLocked: Bool = false

    public var startZoomLevel = 8.0
    public var minZoomLevel = 5.0
    public var maxZoomLevel = 12.0

    public let styleMode: Mode

    public enum Mode {
        case light
        case dark
    }

    public init(
      tiltLocked: Bool = false,
      panLocked: Bool = false,
      zoomLocked: Bool = false,
      rotationLocked: Bool = false,
      startZoomLevel: Double = 8.0,
      minZoomLevel: Double = 5.0,
      maxZoomLevel: Double = 12.0,
      styleMode: Mode = .dark
    ) {
      self.tiltLocked = tiltLocked
      self.panLocked = panLocked
      self.zoomLocked = zoomLocked
      self.rotationLocked = rotationLocked
      self.startZoomLevel = startZoomLevel
      self.minZoomLevel = minZoomLevel
      self.maxZoomLevel = maxZoomLevel
      self.styleMode = styleMode
    }
  }

  public struct PathfindingStyle {
    public let pathStyleHead: LineStyle
    public let pathStyleBody: LineStyle
    public let pathStyleTail: LineStyle
    public let pathCornerRounding: Double // Between 0f..1f,
    public let pathCornerRoundingIterations: Int
    public let pathSmoothing: Double
    public let pathRefreshDistance: Int // In pixels
    public let showPathfindingTail: Bool
    public let showPathfindingBody: Bool

    public let lineEndStyle: CircleStyle?

    public init(
      pathStyleHead: LineStyle = LineStyle(lineColor: UIColor(rgb: 0x1097EC)),
      pathStyleBody: LineStyle = LineStyle(),
      pathStyleTail: LineStyle? = nil,
      pathCornerRounding: Double = 0.3,
      pathCornerRoundingIterations: Int = 6,
      pathSmoothing: Double = 0.025,
      pathRefreshDistance: Int = 100,
      showPathfindingTail: Bool = true,
      showPathfindingBody: Bool = true,
      lineEndStyle: CircleStyle? = nil
    ) {
      self.pathStyleHead = pathStyleHead
      self.pathStyleBody = pathStyleBody
      self.pathStyleTail = pathStyleTail ?? pathStyleBody
      self.pathCornerRounding = pathCornerRounding
      self.pathCornerRoundingIterations = pathCornerRoundingIterations
      self.pathSmoothing = pathSmoothing
      self.pathRefreshDistance = pathRefreshDistance
      self.showPathfindingTail = showPathfindingTail
      self.showPathfindingBody = showPathfindingBody
      self.lineEndStyle = lineEndStyle
    }
  }

  public struct ZoneStyle{
    public let lineStyle: LineStyle
    public let textStyle: TextStyle
    public let fillStyle: FillStyle

    public init(lineStyle: LineStyle = LineStyle(), textStyle: TextStyle = TextStyle(), fillStyle: FillStyle = FillStyle()) {
      self.lineStyle = lineStyle
      self.textStyle = textStyle
      self.fillStyle = fillStyle
    }
  }

  public struct ShelfStyle {
    public let fillStyle: FillStyle
    public let lineStyle: LineStyle
    public let shelfHeight: Double

    public init(fillStyle: FillStyle = FillStyle(), lineStyle: LineStyle = LineStyle(), shelfHeight: Double = 4050.0) {
      self.fillStyle = fillStyle
      self.lineStyle = lineStyle
      self.shelfHeight = shelfHeight
    }
  }

  public struct LineStyle{
    public static let LINE_JOIN_ROUND = "round" // com.mapbox.mapboxsdk.style.layers.Property.LINE_JOIN_ROUND
    public static let LINE_JOIN_BEVEL = "bevel" // com.mapbox.mapboxsdk.style.layers.Property.LINE_JOIN_BEVEL
    public static let LINE_JOIN_MITER = "miter" // com.mapbox.mapboxsdk.style.layers.Property.LINE_JOIN_MITER

    public static let LINE_CAP_ROUND = "round" // com.mapbox.mapboxsdk.style.layers.Property.LINE_CAP_ROUND
    public static let LINE_CAP_SQUARE = "square" // com.mapbox.mapboxsdk.style.layers.Property.LINE_CAP_SQUARE
    public static let LINE_CAP_BUTT = "butt" // com.mapbox.mapboxsdk.style.layers.Property.LINE_CAP_BUTT


    public let lineColor: UIColor
    public let lineColorSelected: UIColor
    public let lineWidth: Double
    public let lineOpacity: Double
    public let lineJoin: String
    public let lineDashLength: Double
    public let lineDashGap: Double
    public let lineCap: String
    public let lineGradient: [String]?

    public init(
      lineColor: UIColor = UIColor(rgb: 0xFFFFFF),
      lineColorSelected: UIColor = UIColor(rgb: 0x1097EC),
      lineWidth: Double = 1.0,
      lineOpacity: Double = 1.0,
      lineJoin: String = LINE_JOIN_ROUND,
      lineDashLength: Double = 1.0,
      lineDashGap: Double = 0.0,
      lineCap: String = LINE_CAP_ROUND,
      lineGradient: [String]? = nil
    ) {
      self.lineColor = lineColor
      self.lineColorSelected = lineColorSelected
      self.lineWidth = lineWidth
      self.lineOpacity = lineOpacity
      self.lineJoin = lineJoin
      self.lineDashLength = lineDashLength
      self.lineDashGap = lineDashGap
      self.lineCap = lineCap
      self.lineGradient = lineGradient
    }
  }

  public struct TextStyle {
    public static let TEXT_ANCHOR_CENTER = "center"
    public static let TEXT_ANCHOR_LEFT = "left"
    public static let TEXT_ANCHOR_RIGHT = "right"
    public static let TEXT_ANCHOR_TOP = "top"
    public static let TEXT_ANCHOR_BOTTOM = "bottom"
    public static let TEXT_ANCHOR_TOP_LEFT = "top-left"
    public static let TEXT_ANCHOR_TOP_RIGHT = "top-right"
    public static let TEXT_ANCHOR_BOTTOM_LEFT = "bottom-left"
    public static let TEXT_ANCHOR_BOTTOM_RIGHT = "bottom-right"
    public static let TEXT_FONT_NOTO_SANS_CJK_JP_BOLD = "Noto Sans CJK JP Bold"

    public let textMinSize: Double
    public let textMaxSize: Double
    public let textColor: UIColor
    public let textColorSelected: UIColor
    public let textOpacity: Double
    public let textIgnorePlacement: Bool
    public let textAnchor: String
    public let textOffset: [Double]
    public let textAllowOverLap: Bool
    public let textFont: String

    public init(
      textMinSize: Double = 10,
      textMaxSize: Double = 25,
      textColor: UIColor = UIColor(rgb: 0x000000),
      textColorSelected: UIColor = UIColor(rgb: 0x000000),
      textOpacity: Double = 1.0,
      textIgnorePlacement: Bool = false,
      textAnchor: String = TEXT_ANCHOR_CENTER,
      textOffset: [Double] = [0.0, 0.0],
      textAllowOverLap: Bool = false,
      textFont: String = TEXT_FONT_NOTO_SANS_CJK_JP_BOLD
    ) {
      self.textMinSize = textMinSize
      self.textMaxSize = textMaxSize
      self.textColor = textColor
      self.textColorSelected = textColorSelected
      self.textOpacity = textOpacity
      self.textIgnorePlacement = textIgnorePlacement
      self.textAnchor = textAnchor
      self.textOffset = textOffset
      self.textAllowOverLap = textAllowOverLap
      self.textFont = textFont
    }
  }

  public struct CircleStyle {
    public let color: UIColor
    public let alpha: Double

    public init(color: UIColor = UIColor(rgb: 0x1097EC), alpha: Double = 0.12) {
      self.color = color
      self.alpha = alpha
    }
  }

  public struct FillStyle {
    public let color: UIColor
    public let colorSelected: UIColor
    public let alpha: Double

    public init(color: UIColor = UIColor(rgb: 0xFFFFFF), colorSelected: UIColor = UIColor(rgb: 0x1097EC), alpha: Double = 0.45) {
      self.color = color
      self.colorSelected = colorSelected
      self.alpha = alpha
    }
  }

  public let userMark: UserMark
  public let mapMark: MapMark
  public let mapStyle: MapStyle
  public let pathfindingStyle: PathfindingStyle
  public let zoneStyle: ZoneStyle
  public let shelfStyle: ShelfStyle
  public let shelfStyleSelected: ShelfStyle

  var markerFallbackImageResource: Int? = nil

  var mapboxLogoEnabled: Bool = true
//  var mapboxLogoGravity: Int = Gravity.START or Gravity.BOTTOM

  var goalImage: Int? = nil
  var startImage: Int? = nil

  var debugControlsEnabled: Bool = false

  public init(
    userMark: UserMark = UserMark(),
    mapMark: MapMark = MapMark(),
    mapStyle: MapStyle = MapStyle(),
    pathfindingStyle: PathfindingStyle = PathfindingStyle(),
    zoneStyle: ZoneStyle = ZoneStyle(),
    shelfStyle: ShelfStyle = ShelfStyle(fillStyle: FillStyle(color: UIColor(rgb: 0x1097EC)), lineStyle: LineStyle(lineColor: UIColor(rgb: 0x000000))),
    shelfStyleSelected: ShelfStyle = ShelfStyle(fillStyle: FillStyle(color: .red, alpha: 1.0), lineStyle: LineStyle())
  ) {
    self.userMark = userMark
    self.mapMark = mapMark
    self.mapStyle = mapStyle
    self.pathfindingStyle = pathfindingStyle
    self.zoneStyle = zoneStyle
    self.shelfStyle = shelfStyle
    self.shelfStyleSelected = shelfStyleSelected
  }
}

private struct MapOptionsOld {
    public let cluster: Cluster
    public let style: MapStyle

    public init(cluster: Cluster, style: MapStyle) {
        self.cluster = cluster
        self.style = style
    }

    public struct MapStyle {
        public let userMarkerType: UserMarkerType
        public let userMarkerColor: UIColor
        public let markerViewColor: UIColor
        public let userMarkerImage: UIImage?
        public let styleMode: Mode
        public let hideMapLogo: Bool
        public let hideAttributionButton: Bool
        public let pathfindingLineColor: UIColor
        public let showPathfindingLineBody: Bool

        public enum UserMarkerType {
            case bullsEye
            case blob
        }

        public enum Mode {
            case light
            case dark
        }

        public init(userMarkerType: UserMarkerType = .bullsEye, userMarkerColor: UIColor = .systemOrange,
                    markerViewColor: UIColor = .white, userMarkerImage: UIImage?, styleMode: Mode = .dark, hideMapLogo: Bool = true,
                    hideAttributionButton: Bool = true, pathfindingLineColor: UIColor = .systemBlue,
                    showPathfindingLineBody: Bool = true) {
            self.userMarkerType = userMarkerType
            self.userMarkerColor = userMarkerColor
            self.markerViewColor = markerViewColor
            self.userMarkerImage = userMarkerImage
            self.styleMode = styleMode
            self.hideMapLogo = hideMapLogo
            self.hideAttributionButton = hideAttributionButton
            self.pathfindingLineColor = pathfindingLineColor
            self.showPathfindingLineBody = showPathfindingLineBody
        }
    }

    public struct Cluster {
        public let clusteringEnabled: Bool
        public let clusterRadius: Double
        public let clusterMaxZoom: Double

        public init(clusteringEnabled: Bool = true, clusterRadius: Double = 12.0, clusterMaxZoom: Double = 20.0) {
            self.clusteringEnabled = clusteringEnabled
            self.clusterRadius = clusterRadius
            self.clusterMaxZoom = clusterMaxZoom
        }
    }
}
