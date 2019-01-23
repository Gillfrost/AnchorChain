//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum DimensionalAnchor { case width, height, size }

    /**
     Constrains one dimension to a constant.

     Passing `.size` as anchor will constrain width to height, and
     return a single constraint to represent both dimensions.

     - Parameters:
     - anchor:    The dimension to constrain, `.width`, `.height` or `.size`.
     - constant:  The constant.
     - priority:  `.required` by default.
     - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: DimensionalAnchor,
                to constant: CGFloat,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        if anchor == .size {
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        return self.anchor(for: anchor)
            .constraint(equalToConstant: constant)
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
