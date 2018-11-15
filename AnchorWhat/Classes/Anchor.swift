//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    func anchor() {
        guard let superview = superview else {
            assertionFailure("View has no superview")
            return
        }
        anchor(to: superview)
    }

    func anchor(to container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        if superview == nil {
            container.addSubview(self)
        }
        topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
}
