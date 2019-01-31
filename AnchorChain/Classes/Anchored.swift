//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    /**
     Constrains a variable number of anchors to match superview.

     - Parameter anchors: `.top, .left, .bottom, .right` by default.

     - Returns: The receiver.
    */
    func anchored(_ anchors: Anchor...) -> Self {
        _ = anchor(anchors)
        return self
    }

    /**
     Constrains a variable number of anchors to match given layout guide of superview.

     - Parameters:
       - anchors:     `.top, .left, .bottom, .right` by default.
       - layoutGuide: The layout guide to match.

     - Returns: The receiver.
     */
    func anchored(_ anchors: Anchor..., to layoutGuide: LayoutGuide) -> Self {
        _ = anchor(anchors, to: layoutGuide)
        return self
    }

    /**
     Constrains a variable number of anchors to match given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - anchors: `.top, .left, .bottom, .right` by default.
       - view:    The view to match.

     - Returns: The receiver.
     */
    func anchored(_ anchors: Anchor..., to view: UIView) -> Self {
        _ = anchor(anchors, to: view)
        return self
    }

    /**
     Constrains a variable number of anchors to match given layout guide of given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - anchors:     `.top, .left, .bottom, .right` by default.
       - layoutGuide: The layout guide to match.
       - view:        The view to match.

     - Returns: The receiver.
     */
    func anchored(_ anchors: Anchor..., to layoutGuide: LayoutGuide, of view: UIView) -> Self {
        _ = anchor(anchors, to: layoutGuide, of: view)
        return self
    }
}
