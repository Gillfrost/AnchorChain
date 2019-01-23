//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

public extension UIView {

    enum Anchor: CaseIterable {
        case top, left, bottom, right
        case leading, trailing
        case centerX, centerY
        case width, height
    }

    /**
     Constrains edges to superview.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor() -> [NSLayoutConstraint] {
        return anchor([])
    }

    /**
     Constrains edges to given layout guide of superview.

     - Parameter layoutGuide:
       The layout guide whose edges should match receiver.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to layoutGuide: LayoutGuide) -> [NSLayoutConstraint] {
        return anchor([], to: layoutGuide)
    }

    /**
     Constrains edges to given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameter view:
       The view whose edges should match receiver.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to view: UIView) -> [NSLayoutConstraint] {
        return anchor([], to: view)
    }

    /**
     Constrains edges to given layout guide of given view.

     - Note:
     **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - layoutGuide: The layout guide to match.
       - view:        The view to match.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to layoutGuide: LayoutGuide, of view: UIView) -> [NSLayoutConstraint] {
        return anchor([], to: layoutGuide, of: view)
    }

    /**
     Constrains one anchor to match superview.

     - Parameters:
       - anchor:    The anchor to match.
       - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], activate: isActive).first ?? .init()
    }

    /**
     Constrains one anchor to match given layout guide of superview.

     - Parameters:
     - anchor:      The anchor to match.
     - layoutGuide: The layout guide to match.
     - isActive:    `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, to layoutGuide: LayoutGuide, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: layoutGuide, activate: isActive).first ?? .init()
    }

    /**
     Constrains one anchor to match given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - anchor:    The anchor to match.
       - view:      The view to match.
       - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
    */
    @discardableResult
    func anchor(_ anchor: Anchor, to view: UIView, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: view, activate: isActive)[0]
    }

    /**
     Constrains one anchor to match given layout guide of given view.

     - Note:
     **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
     - anchor:      The anchor to match.
     - layoutGuide: The layout guide to match.
     - view:        The view to match.
     - isActive:    `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, to layoutGuide: LayoutGuide, of view: UIView, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: layoutGuide, of: view, activate: isActive)[0]
    }

    /**
     Constrains two or more anchors to match superview.

     - Parameters:
       - a1: An anchor.
       - a2: Another anchor.
       - aX: More anchors.

     - Returns: The created array of constraints. Discardable.
    */
    @discardableResult
    func anchor(_ a1: Anchor, _ a2: Anchor, _ aX: Anchor...) -> [NSLayoutConstraint] {
        return anchor([a1, a2] + aX)
    }

    /**
     Constrains two or more anchors to match given layout guide of superview.

     - Parameters:
     - a1:          An anchor.
     - a2:          Another anchor.
     - aX:          More anchors.
     - layoutGuide: The layout guide to match.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(_ a1: Anchor, _ a2: Anchor, _ aX: Anchor..., to layoutGuide: LayoutGuide) -> [NSLayoutConstraint] {
        return anchor([a1, a2] + aX, to: layoutGuide)
    }

    /**
    Constrains two or more anchors to match given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - a1:    An anchor.
       - a2:    Another anchor.
       - aX:    More anchors.
       - view:  The view to match.

    - Returns: The created array of constraints. Discardable.
    */
    @discardableResult
    func anchor(_ a1: Anchor, _ a2: Anchor, _ aX: Anchor..., to view: UIView) -> [NSLayoutConstraint] {
        return anchor([a1, a2] + aX, to: view)
    }

    /**
     Constrains two or more anchors to match given layout guide of given view.

     - Note:
     **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
     - a1:          An anchor.
     - a2:          Another anchor.
     - aX:          More anchors.
     - layoutGuide: The layout guide to match.
     - view:        The view to match.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(_ a1: Anchor, _ a2: Anchor, _ aX: Anchor..., to layoutGuide: LayoutGuide, of view: UIView) -> [NSLayoutConstraint] {
        return anchor([a1, a2] + aX, to: layoutGuide, of: view)
    }
}

extension UIView {

    func anchor(_ anchors: [Anchor], to layoutGuide: LayoutGuide? = nil, activate: Bool = true) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            assertionFailure("View has no superview")
            return []
        }
        return anchor(anchors, to: layoutGuide, of: superview, activate: activate)
    }

    func anchor(_ anchors: [Anchor], to view: UIView, activate: Bool = true) -> [NSLayoutConstraint] {
        return anchor(anchors, to: Optional<LayoutGuide>.none, of: view, activate: activate)
    }

    func anchor(_ anchors: [Anchor], to layoutGuide: LayoutGuide?, of view: UIView, activate: Bool = true) -> [NSLayoutConstraint] {
        prepare(for: view)
        let anchors = anchors.isEmpty ? [.top, .left, .bottom, .right] : anchors
        let anchorable = layoutGuide.map(view.anchorable) ?? view
        let constraints = anchors.map { ($0, anchorable) }.map(constraint)

        if activate {
            NSLayoutConstraint.activate(constraints)
        }

        return constraints
    }

    func disableAutoresizing() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

private extension UIView {

    func prepare(for view: UIView) {
        disableAutoresizing()
        if superview == nil {
            view.addSubview(self)
        }
    }
}

private extension Anchorable {

    func constraint(for anchor: UIView.Anchor, to anchorable: Anchorable) -> NSLayoutConstraint {
        switch anchor {
        case .top:
            return topAnchor.constraint(equalTo: anchorable.topAnchor)
        case .left:
            return leftAnchor.constraint(equalTo: anchorable.leftAnchor)
        case .bottom:
            return bottomAnchor.constraint(equalTo: anchorable.bottomAnchor)
        case .right:
            return rightAnchor.constraint(equalTo: anchorable.rightAnchor)
        case .leading:
            return leadingAnchor.constraint(equalTo: anchorable.leadingAnchor)
        case .trailing:
            return trailingAnchor.constraint(equalTo: anchorable.trailingAnchor)
        case .centerX:
            return centerXAnchor.constraint(equalTo: anchorable.centerXAnchor)
        case .centerY:
            return centerYAnchor.constraint(equalTo: anchorable.centerYAnchor)
        case .width:
            return widthAnchor.constraint(equalTo: anchorable.widthAnchor)
        case .height:
            return heightAnchor.constraint(equalTo: anchorable.heightAnchor)
        }
    }
}

// MARK: - NSLayout extensions

extension NSLayoutAnchor {

    @objc func constraint(with relation: NSLayoutRelation, to anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
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
