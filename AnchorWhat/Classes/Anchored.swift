//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    func anchored(_ anchor: DimensionalAnchor, to constant: CGFloat) -> Self {
        self.anchor(anchor, to: constant)
        return self
    }

    func anchored(_ anchors: Anchor...) -> Self {
        _ = anchor(anchors)
        return self
    }

    func anchored(_ anchors: Anchor..., to view: UIView) -> Self {
        _ = anchor(anchors, to: view)
        return self
    }

    func anchored(_ anchor: YAnchor, to otherAnchor: YAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, to: otherAnchor, of: otherView)
        return self
    }

    func anchored(_ anchor: XAnchor, to otherAnchor: XAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, to: otherAnchor, of: otherView)
        return self
    }

    func anchored(_ anchor: DirectionalXAnchor, to otherAnchor: DirectionalXAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, to: otherAnchor, of: otherView)
        return self
    }
}
