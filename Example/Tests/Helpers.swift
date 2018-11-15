//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

extension UIView {

    func isAttribute(_ attribute: NSLayoutAttribute, constrainedTo view: UIView) -> Bool {
        return constraints.contains {
            $0.firstItem === view
                && $0.secondItem === self
                && $0.firstAttribute == attribute
                && $0.secondAttribute == attribute
        }
    }
}

extension NSLayoutAttribute: CustomStringConvertible {

    public var description: String {
        switch self {
        case .top: return "top"
        case .left: return "left"
        case .bottom: return "bottom"
        case .right: return "right"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .centerX: return "centerX"
        case .centerY: return "centerY"
        case .topMargin: return "topMargin"
        case .leftMargin: return "leftMargin"
        case .bottomMargin: return "bottomMargin"
        case .rightMargin: return "rightMargin"
        case .leadingMargin: return "leadingMargin"
        case .trailingMargin: return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        case .firstBaseline: return "firstBaseline"
        case .lastBaseline: return "lastBaseline"
        case .width: return "width"
        case .height: return "height"
        case .notAnAttribute: return "notAnAttribute"
        }
    }
}
