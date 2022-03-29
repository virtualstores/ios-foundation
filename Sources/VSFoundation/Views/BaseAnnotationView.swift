//
//  BaseAnnotationView.swift
//  
//
//  Created by Hripsime on 2022-03-28.
//

import Foundation
import UIKit

open class BaseAnnotationView: UIView {
    open override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = .red
    }
    
    func createImage(with image: UIImage) {
        let imageView = UIImageView()
        
        self.addSubview(imageView)
        imageView.image = image
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute:.trailing, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        self.layoutIfNeeded()
    }
    
    func createTitleLabel(with text: String?) {
        let label = UILabel()
        
        self.addSubview(label)
        label.backgroundColor = .clear
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.frame.size.width)
        
        let heightConstraint = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        
        let xConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
        
        self.layoutIfNeeded()
    }
    
    open func setup(with model: BaseAnnotationPresentationModel) {
        if let image = model.image {
            createImage(with: image)
        }
        
        createTitleLabel(with: model.name)
    }
}
