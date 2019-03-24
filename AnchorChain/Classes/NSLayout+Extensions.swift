//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import Foundation

extension NSLayoutAnchor {

    @objc func constraint(with relation: NSLayoutConstraint.Relation, to anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor)
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
