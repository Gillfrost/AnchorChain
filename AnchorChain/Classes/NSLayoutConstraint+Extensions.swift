//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import Foundation

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
