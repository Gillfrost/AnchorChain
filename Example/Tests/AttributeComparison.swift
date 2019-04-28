//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

extension UIView {

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute,
                     of layoutGuide: UILayoutGuide? = nil,
                     constrainedTo view: UIView) -> Bool {

        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === layoutGuide ?? self
                && $0.secondAttribute == attribute
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute,
                     of view: UIView,
                     constrainedTo otherAttribute: NSLayoutConstraint.Attribute,
                     of other: AnyObject,
                     withConstant constant: CGFloat) -> Bool {

        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === other
                && $0.secondAttribute == otherAttribute
                && $0.constant == constant
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute, equalTo constant: CGFloat) -> Bool {
        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem == nil
                && $0.secondAttribute == .notAnAttribute
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute,
                     constrainedTo otherAttribute: NSLayoutConstraint.Attribute) -> Bool {

        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem === self
                && $0.secondAttribute == otherAttribute
        }
    }
}
