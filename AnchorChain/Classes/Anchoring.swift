//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    /**
     Constrains one dimension to a constant.

     Passing `.size` as anchor will constrain both width and height to given constant.

     - Parameters:
     - anchor:    The dimension to constrain, `.width`, `.height` or `.size`.
     - constant:  The constant.
     - priority:  `.required` by default.

     - Returns: The receiver.
     */
    func anchoring(_ anchor: DimensionalAnchor,
                   to constant: CGFloat,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, to: constant, priority: priority)

        return self
    }

    func anchoring(_ view: UIView) -> Self {
        _ = view.anchor([], to: self)

        return self
    }

    func anchoring(_ a1: Anchor, _ aX: Anchor..., of view: UIView) -> Self {
        _ = view.anchor([a1] + aX, to: self)

        return self
    }

    func anchoring(_ anchor: YAnchor,
                   _ relation: NSLayoutRelation = .equal,
                   to otherAnchor: YAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, relation, to: otherAnchor, of: otherView, priority: priority)

        return self
    }

    func anchoring(_ anchor: XAnchor,
                   _ relation: NSLayoutRelation = .equal,
                   to otherAnchor: XAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, relation, to: otherAnchor, of: otherView, priority: priority)

        return self
    }

    func anchoring(_ anchor: DirectionalXAnchor,
                   to otherAnchor: DirectionalXAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, to: otherAnchor, of: otherView, priority: priority)

        return self
    }
}
