//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum Anchor: CaseIterable { case top, left, bottom, right, leading, trailing, centerX, centerY }
    enum XAnchor: CaseIterable { case left, right, leading, trailing, centerX }

    @discardableResult
    func anchor(_ anchors: Anchor...) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            assertionFailure("View has no superview")
            return []
        }
        return anchor(anchors, to: superview)
    }

    @discardableResult
    func anchor(_ anchors: Anchor..., to view: UIView) -> [NSLayoutConstraint] {
        return anchor(anchors, to: view)
    }

    @discardableResult
    func anchor(_ anchor: XAnchor, to otherAnchor: XAnchor, of otherView: UIView) -> NSLayoutConstraint {
        disableAutoresizing()
        let constraint = self.anchor(for: anchor).constraint(equalTo: otherView.anchor(for: otherAnchor))

        constraint.isActive = true
        
        return constraint
    }
}

private extension UIView {

    func anchor(_ anchors: [Anchor], to view: UIView) -> [NSLayoutConstraint] {
        prepare(for: view)
        let anchors = anchors.isEmpty ? [.top, .left, .bottom, .right] : anchors
        let constraints = anchors.map { ($0, view) }.map(constraint)

        NSLayoutConstraint.activate(constraints)

        return constraints
    }

    func prepare(for view: UIView) {
        disableAutoresizing()
        if superview == nil {
            view.addSubview(self)
        }
    }

    func disableAutoresizing() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func constraint(for anchor: Anchor, to view: UIView) -> NSLayoutConstraint {
        switch anchor {
        case .top:
            return topAnchor.constraint(equalTo: view.topAnchor)
        case .left:
            return leftAnchor.constraint(equalTo: view.leftAnchor)
        case .bottom:
            return bottomAnchor.constraint(equalTo: view.bottomAnchor)
        case .right:
            return rightAnchor.constraint(equalTo: view.rightAnchor)
        case .leading:
            return leadingAnchor.constraint(equalTo: view.leadingAnchor)
        case .trailing:
            return trailingAnchor.constraint(equalTo: view.trailingAnchor)
        case .centerX:
            return centerXAnchor.constraint(equalTo: view.centerXAnchor)
        case .centerY:
            return centerYAnchor.constraint(equalTo: view.centerYAnchor)
        }
    }

    func anchor(for anchor: XAnchor) -> NSLayoutXAxisAnchor {
        switch anchor {
        case .left:
            return leftAnchor
        case .right:
            return rightAnchor
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
        }
    }
}
