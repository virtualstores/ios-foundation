//
// MapMarkViewHolder.swift
// VSFoundation
//
// Created by Hripsime on 2022-02-18.
// Copyright (c) 2022 Virtual Stores

import Foundation
import UIKit

public class MapMarkViewHolder {
    public var id: String
    public var _renderedBitmap: UIImage?

    public var renderedBitmap: UIImage {
        guard let renderedBitmap = _renderedBitmap else { fatalError("renderedBitmap not loaded")}
        
        return renderedBitmap
    }
    
    public var imageId: String {
        "marker_icon_\(id)"
    }
    
    public init(id: String) {
        self.id = id
    }
}
