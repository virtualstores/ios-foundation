//
// MapFence.swift
// PositionKit
//
// Created by Emil Bond on 2020-08-18.
//
import Foundation
import UIKit

public struct MapFence: Codable {
    public let type: String
    public let properties: Properties
    public let coordinates: [[[[Double]]]]
}

public struct Properties: Codable {
    public let width, height: Double
}
