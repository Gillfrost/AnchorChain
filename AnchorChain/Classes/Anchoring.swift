//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    func anchoring(_ anchor: DimensionalAnchor, to constant: CGFloat) -> Self {
        self.anchor(anchor, to: constant)
        return self
    }

    func anchoring(_ anchors: Anchor..., to view: UIView) -> Self {
        _ = view.anchor(anchors, to: self)
        return self
    }

    func anchoring(_ anchor: YAnchor, _ relation: NSLayoutRelation = .equal, to otherAnchor: YAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, relation, to: otherAnchor, of: otherView)
        return self
    }

    func anchoring(_ anchor: XAnchor, _ relation: NSLayoutRelation = .equal, to otherAnchor: XAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, relation, to: otherAnchor, of: otherView)
        return self
    }

    func anchoring(_ anchor: DirectionalXAnchor, to otherAnchor: DirectionalXAnchor, of otherView: UIView) -> Self {
        self.anchor(anchor, to: otherAnchor, of: otherView)
        return self
    }
}
