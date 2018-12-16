//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    func anchored(_ anchors: Anchor...) -> Self {
        _ = anchor(anchors)
        return self
    }

    func anchored(_ anchors: Anchor..., to view: UIView) -> Self {
        _ = anchor(anchors, to: view)
        return self
    }
}
