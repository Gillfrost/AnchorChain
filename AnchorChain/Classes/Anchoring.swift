//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    /**
     Constrains one dimension to a constant.

     Passing `.size` as anchor will constrain both width and height to given constant.

     - Parameters:
       - anchor:    The dimension to constrain, `.width`, `.height` or `.size`.
       - relation: `.equal` by default.
       - constant:  The constant.
       - priority:  `.required` by default.

     - Returns: The receiver.
     */
    func anchoring(_ anchor: DimensionalAnchor,
                   _ relation: NSLayoutConstraint.Relation = .equal,
                   to constant: CGFloat,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, relation, to: constant, priority: priority)

        return self
    }

    /**
     Constrains edges of given view to receiver.

     - Note:
       **Given view is automatically added as subview to receiver, if it is without superview.**

     - Parameter view: The view whose edges should match receiver.

     - Returns: The receiver.
     */
    func anchoring(_ view: UIView) -> Self {

        _ = view.anchor([], to: self)

        return self
    }

    /**
     Constrains edges of given view to given layout guide of receiver.

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

    /**
     Constrains one or more anchors of given view to match receiver.

     - Note:
       **Given view is automatically added as subview to receiver, if it is without superview.**

     - Parameters:
       - a1:          An anchor.
       - aX:          More anchors.
       - view:        The view to match.

     - Returns: The receiver.
     */
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

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The vertical anchor in the receiver.
       - relation:      `.equal` by default.
       - otherAnchor:   The vertical anchor to align with.
       - otherView:     The view to align with.
       - priority:      `.required` by default.

     - Returns: The receiver.
     */
    func anchoring(_ anchor: YAnchor,
                   _ relation: NSLayoutConstraint.Relation = .equal,
                   to otherAnchor: YAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, relation, to: otherAnchor, of: otherView, priority: priority)

        return self
    }

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The horizontal anchor in the receiver.
       - relation:      `.equal` by default.
       - otherAnchor:   The horizontal anchor to align with.
       - otherView:     The view to align with.
       - priority:      `.required` by default.

     - Returns: The receiver.
     */
    func anchoring(_ anchor: XAnchor,
                   _ relation: NSLayoutConstraint.Relation = .equal,
                   to otherAnchor: XAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, relation, to: otherAnchor, of: otherView, priority: priority)

        return self
    }

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The directional horizontal anchor in the receiver.
       - relation:      `.equal` by default.
       - otherAnchor:   The directional horizontal anchor to align with.
       - otherView:     The view to align with.
       - priority:      `.required` by default.

     - Returns: The receiver.
     */
    func anchoring(_ anchor: DirectionalXAnchor,
                   to otherAnchor: DirectionalXAnchor,
                   of otherView: UIView,
                   priority: UILayoutPriority = .required) -> Self {

        self.anchor(anchor, to: otherAnchor, of: otherView, priority: priority)

        return self
    }
}
