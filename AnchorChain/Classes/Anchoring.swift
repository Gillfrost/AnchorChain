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

    /**
     Constrains given view to given layout guide of receiver.

     - Note:
       **Given view is automatically added as subview to receiver, if it is without superview.**

     - Parameters:
       - view:        The view whose edges should match given layout guide of receiver.
       - layoutGuide: The layout guide in receiver to match.

     - Returns: The receiver.
     */
    func anchoring(_ view: UIView, to layoutGuide: LayoutGuide) -> Self {

        _ = view.anchor([], to: layoutGuide, of: self)

        return self
    }

    func anchoring(_ a1: Anchor, _ aX: Anchor..., of view: UIView) -> Self {

        _ = view.anchor([a1] + aX, to: self)

        return self
    }

    /**
     Constrains one or more anchors of given view to match given layout guide of receiver.

     - Note:
       **Given view is automatically added as subview to receiver, if it is without superview.**

     - Parameters:
       - a1:          An anchor.
       - aX:          More anchors.
       - view:        The view to match.
       - layoutGuide: The layout guide in receiver to match.

     - Returns: The receiver.
     */
    func anchoring(_ a1: Anchor, _ aX: Anchor..., of view: UIView, to layoutGuide: LayoutGuide) -> Self {

        _ = view.anchor([a1] + aX, to: layoutGuide, of: self)

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
