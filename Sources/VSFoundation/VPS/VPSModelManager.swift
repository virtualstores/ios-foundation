//
//  File.swift
//  
//
//  Created by Théodore Roos on 2023-05-29.
//

import Foundation
import CoreML

public protocol VPSModelManager {
  var model: MLModel? { get }
}
