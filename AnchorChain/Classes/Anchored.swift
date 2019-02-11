//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    /**
     Constrains edges to superview.

     - Returns: The receiver.
     */
    func anchored() -> Self {
        anchor()
        return self
    }

    /**
     Constrains edges to superview with insets.

     - Parameter insets: The insets to use.

     - Returns: The receiver.
     */
    func anchored(with insets: UIEdgeInsets) -> Self {
        anchor(with: insets)
        return self
    }

    /**
     Constrains a variable number of anchors to match superview.

     - Parameters:
       -  a1: An anchor.
       -  aX: More anchors.

     - Returns: The receiver.
    */
    func anchored(_ a1: Anchor, _ aX: Anchor...) -> Self {
        _ = anchor([a1] + aX)
        return self
    }

    /**
     Constrains edges to given layout guide of superview.

     - Parameter layoutGuide:
       The layout guide in superview whose edges receiver should match.

     - Returns: The receiver.
     */
    func anchored(to layoutGuide: LayoutGuide) -> Self {
        anchor(to: layoutGuide)
        return self
    }

    /**
     Constrains edges to given layout guide of superview with insets.

     - Parameters:
       - layoutGuide: The layout guide in superview whose edges receiver should match.
       - insets:      The insets to use.

     - Returns: The receiver.
     */
    func anchored(to layoutGuide: LayoutGuide, with insets: UIEdgeInsets) -> Self {
        anchor(to: layoutGuide, with: insets)
        return self
    }

    /**
     Constrains a variable number of anchors to match given layout guide of superview.

     - Parameters:
       - a1:          An anchor.
       - aX:          More anchors.
       - layoutGuide: The layout guide to match.

     - Returns: The receiver.
     */
    func anchored(_ a1: Anchor,_ aX: Anchor..., to layoutGuide: LayoutGuide) -> Self {
        _ = anchor([a1] + aX, to: layoutGuide)
        return self
    }

    /**
     Constrains edges to given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameter view: The view to match.

     - Returns: The receiver.
     */
    func anchored(to view: UIView) -> Self {
        anchor(to: view)
        return self
    }

    /**
     Constrains edges to given view with insets.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - view:   The view to match.
       - insets: The insets to use.

     - Returns: The receiver.
     */
    func anchored(to view: UIView, with insets: UIEdgeInsets) -> Self {
        anchor(to: view, with: insets)
        return self
    }

    /**
     Constrains a variable number of anchors to match given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - a1:   An anchor.
       - aX:   More anchors.
       - view: The view to match.

     - Returns: The receiver.
     */
    func anchored(_ a1: Anchor, _ aX: Anchor..., to view: UIView) -> Self {
        _ = anchor([a1] + aX, to: view)
        return self
    }

    /**
     Constrains edges to given layout guide of given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - layoutGuide: The layout guide to match.
       - view:        The view to match.

     - Returns: The receiver.
     */
    func anchored(to layoutGuide: LayoutGuide, of view: UIView) -> Self {
        anchor(to: layoutGuide, of: view)
        return self
    }

    /**
     Constrains edges to given layout guide of given view with insets.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - layoutGuide: The layout guide to match.
       - view:        The view to match.
       - insets:      The insets to use.

     - Returns: The receiver.
     */
    func anchored(to layoutGuide: LayoutGuide, of view: UIView, with insets: UIEdgeInsets) -> Self {
        anchor(to: layoutGuide, of: view, with: insets)
        return self
    }

    /**
     Constrains a variable number of anchors to match given layout guide of given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - a1:          An anchor.
       - aX:          More anchors.
       - layoutGuide: The layout guide to match.
       - view:        The view to match.

     - Returns: The receiver.
     */
    func anchored(_ a1: Anchor, _ aX: Anchor..., to layoutGuide: LayoutGuide, of view: UIView) -> Self {
        _ = anchor([a1] + aX, to: layoutGuide, of: view)
        return self
    }
}
