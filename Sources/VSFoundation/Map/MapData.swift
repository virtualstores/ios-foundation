//
// MapData.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-07.
// Copyright (c) 2022 Virtual Stores

import Foundation

public class MapData {
    public var rtlsOptions: RtlsOptions
    public var style: MapStyle
    public var converter: ICoordinateConverter
    
    public init(rtlsOptions: RtlsOptions, style: MapStyle, converter: ICoordinateConverter) {
        self.rtlsOptions = rtlsOptions
        self.style = style
        self.converter = converter
    }
}
