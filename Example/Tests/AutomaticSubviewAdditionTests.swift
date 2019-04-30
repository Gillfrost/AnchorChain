//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AutomaticSubviewAdditionTests: XCTestCase {

    // MARK: Anchor API

    func test_AnchorApi_AnchoringAddsReceiverToOther_IfReceiverIsWithoutSuperview() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: other)

        XCTAssertEqual(view.superview, other)
    }

    func test_AnchorApi_AnchoringDoesNotAddReceiverToOther_IfReceiverAlreadyHasASuperview() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)
        view.anchor(to: other)

        XCTAssertEqual(view.superview, superview)
    }

    // MARK: - Anchored API

    func test_AnchoredApi_AnchoringAddsReceiverToOther_IfReceiverIsWithoutSuperview() {
        let other = UIView()

        XCTAssertEqual(UIView().anchored(to: other).superview, other)
    }

    func test_AnchoredApi_AnchoringDoesNotAddReceiverToOther_IfReceiverAlreadyHasASuperview() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)

        XCTAssertEqual(view.anchored(to: other).superview, superview)
    }

}
