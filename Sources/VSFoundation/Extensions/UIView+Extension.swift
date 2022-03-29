//
//  UIView+Extension.swift
//  
//
//  Created by Hripsime on 2022-03-28.
//

import Foundation
import UIKit

public extension NSObject {
    static func className<T: NSObject>(_ type: T.Type) -> String {
        return String(describing: type)
    }
}

/// Defines reusable identifier to be used for cells and view, and for any other reusable view
public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return className(self)
    }
}

/// Defines name of nib for view to be used for loading from nib
public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return className(self)
    }
}

extension UIView {
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// MARK: - UIView extension to use as reusable view
extension UIView: NibLoadableView {
    public class func loadNib<T: UIView>(for viewType: T.Type, bundle: Bundle? = nil) -> T? {
        let bundle = bundle ?? Bundle(for: viewType)

        if bundle.path(forResource: nibName, ofType: "nib") != nil {
            return bundle.loadNibNamed(nibName, owner: nil, options: nil)!.first as? T
        }

        return nil
    }

    public class func loadNib() -> Self? {
        return loadNib(for: self)
    }
}
