//
// MapStyle.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit

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
