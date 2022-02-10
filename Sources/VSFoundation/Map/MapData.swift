//
// MapData.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation

public class MapData {
    var style: MapStyle
    var camera: Camera
    
    init(style: MapStyle, camera: Camera) {
        self.style = style
        self.camera = camera
    }
}
