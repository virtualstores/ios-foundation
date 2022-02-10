//
// MapData.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation

public class MapData {
    var rtlsOptions: RtlsOptions
    var style: MapStyle
    
    init(rtlsOptions: RtlsOptions, style: MapStyle) {
        self.rtlsOptions = rtlsOptions
        self.style = style
    }
}