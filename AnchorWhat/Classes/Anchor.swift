//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    func anchor(to other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        if superview == nil {
            other.addSubview(self)
        }
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
    }
}
