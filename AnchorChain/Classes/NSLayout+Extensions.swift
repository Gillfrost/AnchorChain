//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import Foundation

extension NSLayoutAnchor {

    @objc func constraint(with relation: NSLayoutConstraint.Relation,
                          to anchor: NSLayoutAnchor<AnchorType>,
                          constant: CGFloat) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
        @unknown default:
            return NSLayoutConstraint()
        }
    }
}

extension NSLayoutConstraint {

    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    func isActive(_ isActive: Bool) -> Self {
        self.isActive = isActive
        return self
    }
}
