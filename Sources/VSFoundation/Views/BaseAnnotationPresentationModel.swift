//
//  AnnotationPresentationModel.swift
//  ios-active-demo-app
//
//  Created by Hripsime on 2022-03-28.
//

import Foundation
import UIKit

public protocol BaseAnnotation {
    var name: String? { get set }
    var image: UIImage? { get set }
}

open class BaseAnnotationPresentationModel: BaseAnnotation {
    private var annotationData: AnnotationData
    
    public var name: String? {
        get { annotationData.name }
        set { self.name = newValue }
    }
    
    public var image: UIImage? {
        get { annotationData.image }
        set { self.image = newValue }
    }
    
    public init(data: AnnotationData) {
        self.annotationData = data
    }
}
