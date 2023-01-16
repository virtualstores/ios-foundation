//
// CameraModes.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation

// CameraModes which can have user
public enum CameraModes {
    case free
    case containMap
    case threeDimensional(_ zoomLevel: Double? = nil)
}
