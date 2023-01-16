//
// MapFence.swift
// PositionKit
//
// Created by Emil Bond on 2020-08-18.
//
import Foundation
#if canImport(UIKit)
import UIKit

// Code specific to platforms where UIKit is available
public struct MapFence: Codable {
    public let type: String
    public let properties: Properties
    public let coordinates: [[[[Double]]]]
}

public struct Properties: Codable {
    public let width, height: Double
}
#endif
