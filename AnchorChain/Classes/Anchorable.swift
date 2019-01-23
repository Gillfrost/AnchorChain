//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

protocol Anchorable {

    var topAnchor: NSLayoutYAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }

    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension UIView: Anchorable {

    public enum LayoutGuide { case safeArea, layoutMargins, readableContent }

    func anchorable(for layoutGuide: LayoutGuide) -> Anchorable {
        switch layoutGuide {
        case .safeArea:
            return safeAreaLayoutGuide
        case .layoutMargins:
            return layoutMarginsGuide
        case .readableContent:
            return readableContentGuide
        }
    }
}

extension UILayoutGuide: Anchorable {}
