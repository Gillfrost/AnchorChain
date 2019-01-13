//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit

// MARK: - Dimensioning

public extension UIView {

    enum DimensionalAnchor { case width, height, size }

    // MARK: - Interface

    /**
     Constrains one dimension to a constant.

     Passing `.size` as anchor will constrain width to height, and
     return a single constraint to represent both dimensions.

     - Parameters:
       - anchor:    The dimension to constrain, `width`, `height` or `size`.
       - to:        The constant.
       - priority:  `required` by default.
       - isActive:  `true` by default.

     - Returns: The created constraint. Discardable.
    */
    @discardableResult
    func anchor(_ anchor: DimensionalAnchor,
                to constant: CGFloat,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        if anchor == .size {
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        return self.anchor(for: anchor)
            .constraint(equalToConstant: constant)
            .priority(priority)
            .isActive(isActive)
    }

    // MARK: - Private

    private func anchor(for anchor: DimensionalAnchor) -> NSLayoutDimension {
        switch anchor {
        case .width, .size:
            return widthAnchor
        case .height:
            return heightAnchor
        }
    }
}

// MARK: -  Matching

public extension UIView {

    enum Anchor: CaseIterable {
        case top, left, bottom, right
        case leading, trailing
        case centerX, centerY
        case width, height
    }

    // MARK: - Interface

    /**
     Constrains edges to superview.

     - Returns: The created array of constraints. Discardable.
     */
    @discardableResult
    func anchor() -> [NSLayoutConstraint] {
        return anchor([])
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

    // MARK: - Internal

    func anchor(_ anchors: [Anchor], activate: Bool = true) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            assertionFailure("View has no superview")
            return []
        }
        return anchor(anchors, to: superview, activate: activate)
    }

    func anchor(_ anchors: [Anchor], to view: UIView, activate: Bool = true) -> [NSLayoutConstraint] {
        prepare(for: view)
        let anchors = anchors.isEmpty ? [.top, .left, .bottom, .right] : anchors
        let constraints = anchors.map { ($0, view) }.map(constraint)

        if activate {
            NSLayoutConstraint.activate(constraints)
        }

        return constraints
    }

    // MARK: - Private

    private func prepare(for view: UIView) {
        disableAutoresizing()
        if superview == nil {
            view.addSubview(self)
        }
    }

    private func disableAutoresizing() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func constraint(for anchor: Anchor, to view: UIView) -> NSLayoutConstraint {
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
        case .width:
            return widthAnchor.constraint(equalTo: view.widthAnchor)
        case .height:
            return heightAnchor.constraint(equalTo: view.heightAnchor)
        }
    }
}

// MARK: - Horizontal alignment

public extension UIView {

    enum XAnchor: CaseIterable { case left, right, centerX }

    // MARK: - Interface

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
       - anchor:        The horizontal anchor in the receiver.
       - relation:      `equal` by default.
       - otherAnchor:   The horizontal anchor to align with.
       - otherView:     The view to align with.
       - priority:      `required` by default.
       - isActive:      `true` by default.

     - Returns: The created constraint.
     */
    @discardableResult
    func anchor(_ anchor: XAnchor,
                _ relation: NSLayoutRelation = .equal,
                to otherAnchor: XAnchor,
                of otherView: UIView,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        disableAutoresizing()

        return self.anchor(for: anchor)
            .constraint(with: relation, to: otherView.anchor(for: otherAnchor))
            .priority(priority)
            .isActive(isActive)
    }

    // MARK: - Private

    private func anchor(for anchor: XAnchor) -> NSLayoutXAxisAnchor {
        switch anchor {
        case .left:
            return leftAnchor
        case .right:
            return rightAnchor
        case .centerX:
            return centerXAnchor
        }
    }

}

// MARK: - Vertical alignment

public extension UIView {
    enum YAnchor: CaseIterable { case top, bottom, centerY }

    // MARK: - Interface

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
     - anchor:        The vertical anchor in the receiver.
     - relation:      `equal` by default.
     - otherAnchor:   The vertical anchor to align with.
     - otherView:     The view to align with.
     - priority:      `required` by default.
     - isActive:      `true` by default.

     - Returns: The created constraint.
     */
    @discardableResult
    func anchor(_ anchor: YAnchor,
                _ relation: NSLayoutRelation = .equal,
                to otherAnchor: YAnchor,
                of otherView: UIView,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        disableAutoresizing()
        return self.anchor(for: anchor)
            .constraint(with: relation, to: otherView.anchor(for: otherAnchor))
            .priority(priority)
            .isActive(isActive)
    }

    // MARK: - Private

    private func anchor(for anchor: YAnchor) -> NSLayoutYAxisAnchor {
        switch anchor {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        }
    }
}

// MARK: - Directional horizontal alignment

public extension UIView {
    enum DirectionalXAnchor: CaseIterable { case leading, trailing, centerX }

    // MARK: - Interface

    /**
     Constrains an anchor to given anchor in given view.

     - Parameters:
     - anchor:        The directional horizontal anchor in the receiver.
     - relation:      `equal` by default.
     - otherAnchor:   The directional horizontal anchor to align with.
     - otherView:     The view to align with.
     - priority:      `required` by default.
     - isActive:      `true` by default.

     - Returns: The created constraint.
     */
    @discardableResult
    func anchor(_ anchor: DirectionalXAnchor,
                to otherAnchor: DirectionalXAnchor,
                of otherView: UIView,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {

        disableAutoresizing()
        return self.anchor(for: anchor)
            .constraint(equalTo: otherView.anchor(for: otherAnchor))
            .priority(priority)
            .isActive(isActive)
    }

    // MARK: - Private

    private func anchor(for anchor: DirectionalXAnchor) -> NSLayoutXAxisAnchor {
        switch anchor {
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
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
