//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum XAnchor { case left, right, centerX }

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The horizontal anchor in the receiver.
       - relation:      `.equal` by default.
       - otherAnchor:   The horizontal anchor to align with.
       - otherView:     The view to align with.
       - priority:      `.required` by default.
       - isActive:      `true` by default.

     - Returns: The created constraint.
     */
    @discardableResult
    func anchor(_ anchor: XAnchor,
                _ relation: NSLayoutConstraint.Relation = .equal,
                to otherAnchor: XAnchor,
                of otherView: UIView,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        disableAutoresizing()

        return self.anchor(for: anchor)
            .constraint(with: relation, to: otherView.anchor(for: otherAnchor))
            .priority(priority)
            .isActive(isActive)
    }
}

private extension Anchorable {

    func anchor(for anchor: UIView.XAnchor) -> NSLayoutXAxisAnchor {
        switch anchor {
        case .left:
            return leftAnchor
        case .right:
            return rightAnchor
        case .centerX:
            return centerXAnchor
        }
    }
}
