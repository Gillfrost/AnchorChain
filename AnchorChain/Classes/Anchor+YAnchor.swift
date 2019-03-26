//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum YAnchor { case top, bottom, centerY }

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The vertical anchor in the receiver.
       - relation:      `.equal` by default.
       - otherAnchor:   The vertical anchor to align with.
       - otherView:     The view to align with.
       - constant:      `0` by default.
       - priority:      `.required` by default.
       - isActive:      `true` by default.

     - Returns: The created constraint.
     */
    @discardableResult
    func anchor(_ anchor: YAnchor,
                _ relation: NSLayoutConstraint.Relation = .equal,
                to otherAnchor: YAnchor,
                of otherView: UIView,
                constant: CGFloat = 0,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        disableAutoresizing()

        return self.anchor(for: anchor)
            .constraint(with: relation, to: otherView.anchor(for: otherAnchor), constant: constant)
            .priority(priority)
            .isActive(isActive)
    }
}

private extension Anchorable {

    func anchor(for anchor: UIView.YAnchor) -> NSLayoutYAxisAnchor {
        switch anchor {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        }
    }
}
