//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum DimensionalAnchor { case width, height, size }

    /**
     Constrains one dimension to a constant.

     Passing `.size` as anchor will constrain width to height, and
     return a single constraint whose constant represents both dimensions.

     - Parameters:
     - anchor:    The dimension to constrain, `.width`, `.height` or `.size`.
     - relation:  `.equal` by default.
     - constant:  The constant.
     - priority:  `.required` by default.
     - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: DimensionalAnchor,
                _ relation: NSLayoutRelation = .equal,
                to constant: CGFloat,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        if anchor == .size {
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        return self.anchor(for: anchor)
            .constraint(relation, to: constant)
            .priority(priority)
            .isActive(isActive)
    }
}

private extension Anchorable {

    func anchor(for anchor: UIView.DimensionalAnchor) -> NSLayoutDimension {
        switch anchor {
        case .width, .size:
            return widthAnchor
        case .height:
            return heightAnchor
        }
    }
}

private extension NSLayoutDimension {

    func constraint(_ relation: NSLayoutRelation, to constant: CGFloat) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalToConstant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualToConstant: constant)
        }
    }
}
