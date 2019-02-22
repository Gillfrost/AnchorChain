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
     Constrains edges to superview with insets.

     - Parameter insets: The insets to use.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(with insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return anchor([], with: insets)
    }

    /**
     Constrains edges to given layout guide of superview.

     - Parameter layoutGuide:
       The layout guide in superview whose edges receiver should match.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to layoutGuide: LayoutGuide) -> [NSLayoutConstraint] {
        return anchor([], to: layoutGuide)
    }

    /**
     Constrains edges to given layout guide of superview with insets.

     - Parameters:
       - layoutGuide: The layout guide in superview whose edges receiver should match.
       - insets:      The insets to use.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to layoutGuide: LayoutGuide, with insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return anchor([], to: layoutGuide, with: insets)
    }

    /**
     Constrains edges to given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameter view:
       The view whose edges receiver should match.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to view: UIView) -> [NSLayoutConstraint] {
        return anchor([], to: view)
    }

    /**
     Constrains edges to given view with insets.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - view:   The view whose edges receiver should match.
       - insets: The insets to use.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to view: UIView, with insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return anchor([], to: view, with: insets)
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
     Constrains edges to given layout guide of given view with insets.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - layoutGuide: The layout guide to match.
       - view:        The view to match.
       - insets:      The insets to use.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor(to layoutGuide: LayoutGuide, of view: UIView, with insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return anchor([], to: layoutGuide, of: view, with: insets)
    }

    /**
     Constrains one anchor to match superview.

     - Parameters:
       - anchor:   The anchor to match.
       - priority: `required`by default.
       - isActive: `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], priority: priority, activate: isActive).first ?? .init()
    }

    /**
     Constrains one anchor to match given layout guide of superview.

     - Parameters:
       - anchor:      The anchor to match.
       - layoutGuide: The layout guide to match.
       - priority:    `required`by default.
       - isActive:    `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, to layoutGuide: LayoutGuide, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: layoutGuide, priority: priority, activate: isActive).first ?? .init()
    }

    /**
     Constrains one anchor to match given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - anchor:    The anchor to match.
       - view:      The view to match.
       - priority:  `required`by default.
       - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
    */
    @discardableResult
    func anchor(_ anchor: Anchor, to view: UIView, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: view, priority: priority, activate: isActive)[0]
    }

    /**
     Constrains one anchor to match given layout guide of given view.

     - Note:
       **Receiver is automatically added as subview to given view, if receiver is without superview.**

     - Parameters:
       - anchor:      The anchor to match.
       - layoutGuide: The layout guide to match.
       - view:        The view to match.
       - priority:    `required`by default.
       - isActive:    `true` by default.

     - Returns: The created constraint. Discardable.
     */
    @discardableResult
    func anchor(_ anchor: Anchor, to layoutGuide: LayoutGuide, of view: UIView, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return self.anchor([anchor], to: layoutGuide, of: view, priority: priority, activate: isActive)[0]
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

    func anchor(_ anchors: [Anchor],
                to layoutGuide: LayoutGuide? = nil,
                with insets: UIEdgeInsets = .zero,
                priority: UILayoutPriority = .required,
                activate: Bool = true) -> [NSLayoutConstraint] {

        guard let superview = superview else {
            assertionFailure("View has no superview")
            return []
        }
        return anchor(anchors, to: layoutGuide, of: superview, with: insets, priority: priority, activate: activate)
    }

    func anchor(_ anchors: [Anchor],
                to view: UIView,
                with insets: UIEdgeInsets = .zero,
                priority: UILayoutPriority = .required,
                activate: Bool = true) -> [NSLayoutConstraint] {

        return anchor(anchors, to: Optional<LayoutGuide>.none, of: view, with: insets, priority: priority, activate: activate)
    }

    func anchor(_ anchors: [Anchor],
                to layoutGuide: LayoutGuide?,
                of view: UIView,
                with insets: UIEdgeInsets = .zero,
                priority: UILayoutPriority = .required,
                activate: Bool = true) -> [NSLayoutConstraint] {
        prepare(for: view)

        let anchorsWithConstants = anchors.isEmpty
            ? Array(zip([.top, .left, .bottom, .right],
                        [insets.top, insets.left, -insets.bottom, -insets.right]))
            : anchors.map { ($0, CGFloat(0)) }
        let anchorable = layoutGuide.map(view.anchorable) ?? view
        let constraints = anchorsWithConstants.map { ($0, anchorable, $1) }.map(constraint)

        if priority != .required {
            constraints.forEach { $0.priority = priority }
        }

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

    func constraint(for anchor: UIView.Anchor, to anchorable: Anchorable, constant: CGFloat) -> NSLayoutConstraint {
        switch anchor {
        case .top:
            return topAnchor.constraint(equalTo: anchorable.topAnchor, constant: constant)
        case .left:
            return leftAnchor.constraint(equalTo: anchorable.leftAnchor, constant: constant)
        case .bottom:
            return bottomAnchor.constraint(equalTo: anchorable.bottomAnchor, constant: constant)
        case .right:
            return rightAnchor.constraint(equalTo: anchorable.rightAnchor, constant: constant)
        case .leading:
            return leadingAnchor.constraint(equalTo: anchorable.leadingAnchor, constant: constant)
        case .trailing:
            return trailingAnchor.constraint(equalTo: anchorable.trailingAnchor, constant: constant)
        case .centerX:
            return centerXAnchor.constraint(equalTo: anchorable.centerXAnchor, constant: constant)
        case .centerY:
            return centerYAnchor.constraint(equalTo: anchorable.centerYAnchor, constant: constant)
        case .width:
            return widthAnchor.constraint(equalTo: anchorable.widthAnchor, constant: constant)
        case .height:
            return heightAnchor.constraint(equalTo: anchorable.heightAnchor, constant: constant)
        }
    }
}

// MARK: - NSLayout extensions

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
