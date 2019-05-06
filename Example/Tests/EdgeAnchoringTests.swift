//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class EdgeAnchoringTests: XCTestCase {

    // MARK: - Anchor API

    func testAnchorApi_EdgeAnchorsAreAssumed_IfNotSpecified() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: other)

        expect(.top, .left, .bottom, .right, of: view, toMatch: other)
    }

    func testAnchorApi_EdgeAnchorsTargetingSuperviewAreAssumed_IfNotSpecified() {
        viewAndSuperview { view, superview in

            view.anchor()

            expect(.top, .left, .bottom, .right, of: view, toMatch: superview)
        }
    }

    // MARK: - Anchored API

    func testAnchoredApi_EdgeAnchorsAreAssumed_IfNotSpecified() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: UIView().anchored(to: other), toMatch: other)
    }

    func testAnchoredApi_EdgeAnchorsTargetingSuperviewAreAssumed_IfNotSpecified() {
        viewAndSuperview { view, superview in

            expect(.top, .left, .bottom, .right, of: view.anchored(), toMatch: superview)
        }
    }

    // MARK: - Anchoring API

    func testAnchoringApi_EdgeAnchorsAreAssumed_IfNotSpecified() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: other, toMatch: UIView().anchoring(other))
    }
}
